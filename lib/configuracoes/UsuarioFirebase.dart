
import 'package:churras_hammer/model/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsuarioFirebase {

  static Future<FirebaseUser> getUsuarioAtual() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return await auth.currentUser();
  }

  static Future<Usuario> getDadosUsuarioLogado() async {
    FirebaseUser firebaseUser = await getUsuarioAtual();
    String idUsuario = firebaseUser.uid;

    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot = await db.collection("usuarios").document(
        idUsuario).get();

    Map<String, dynamic> dados = snapshot.data;
    String id = dados["id"];
    String nome = dados["nome"];
    String email = dados["email"];
    String statusEvento = dados["statusEvento"];
    String statusConvidado = dados["statusConvidado"];
    String valor = dados["valor"];



    Usuario usuario = Usuario();
    usuario.id = id;
    usuario.nome = nome;
    usuario.email = email;
    usuario.statusEvento = statusEvento;
    usuario.statusConvidado = statusEvento;
    usuario.valor = valor;

    return usuario;
  }

}