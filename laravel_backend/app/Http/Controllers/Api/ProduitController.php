<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use DB;
use App\Models\Produit;

class ProduitController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $produit = DB::table('produits')->get();
        return response()->json($produit);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'refProd' => 'required',
            'nomProd' => 'required',
            'prixAchat' => 'required',
            'prixVente' => 'required',
            'descriptionProd',
            'stock' => 'required',
            'imageProd' => 'mimes:jpg,png,jpeg,gif,svg'
        ]);
        $data= array();
        $data['refProd'] = $request->refProd;
        $data['nomProd'] = $request->nomProd;
        $data['prixAchat'] = $request->prixAchat;
        $data['prixVente'] = $request->prixVente;
        $data['stock'] = $request->stock;
        $data['descriptionProd']= $request->descriptionProd;
        $data['TVA']= $request->TVA;
        /**
        *  $imageProd = $request->file('imageProd');
        * $name_gen = hexdec(uniqid());
        * $img_ext = strtolower($imageProd->getClientOriginalExtension());
        * $img_name = $name_gen.'.'.$img_ext;
        * $up_location = 'public/produit';
        * $last_img = $up_location.$img_name;
        * $imageProd->move($up_location,$img_name);
        * $data['imageProd'] = $last_img;
        **/
        $insert = DB::table('produits')->insert($data);
        return response('Produit Ajouté');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $show = DB::table('produits')->where('id', $id)->first();
        return response()->json($show);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {

    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $data= array();
        $data['refProd'] = $request->refProd;
        $data['stock'] = $request->stock;
        $data['nomProd'] = $request->nomProd;
        $data['prixAchat'] = $request->prixAchat;
        $data['descriptionProd']= $request->descriptionProd;
        $data['TVA']= $request->TVA;
        $insert = DB::table('produits')->where('id',$id)->update($data);
        return response()->json('Produit Modifié');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        DB::table('produits')->where('id', $id)->delete();
        return reponse('Produit Supprimé');
    }
}
