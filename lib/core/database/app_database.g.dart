// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HinosTable extends Hinos with TableInfo<$HinosTable, HinoData>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$HinosTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
@override
late final GeneratedColumn<int> numero = GeneratedColumn<int>('numero', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
@override
late final GeneratedColumn<String> titulo = GeneratedColumn<String>('titulo', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _letraMeta = const VerificationMeta('letra');
@override
late final GeneratedColumn<String> letra = GeneratedColumn<String>('letra', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _autorMeta = const VerificationMeta('autor');
@override
late final GeneratedColumn<String> autor = GeneratedColumn<String>('autor', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _audioUrlMeta = const VerificationMeta('audioUrl');
@override
late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>('audio_url', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _audioLocalPathMeta = const VerificationMeta('audioLocalPath');
@override
late final GeneratedColumn<String> audioLocalPath = GeneratedColumn<String>('audio_local_path', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _isFavoritoMeta = const VerificationMeta('isFavorito');
@override
late final GeneratedColumn<bool> isFavorito = GeneratedColumn<bool>('is_favorito', aliasedName, false, type: DriftSqlType.bool, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_favorito" IN (0, 1))'), defaultValue: const Constant(false));
static const VerificationMeta _isDownloadedMeta = const VerificationMeta('isDownloaded');
@override
late final GeneratedColumn<bool> isDownloaded = GeneratedColumn<bool>('is_downloaded', aliasedName, false, type: DriftSqlType.bool, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_downloaded" IN (0, 1))'), defaultValue: const Constant(false));
@override
List<GeneratedColumn> get $columns => [id, numero, titulo, letra, autor, audioUrl, audioLocalPath, isFavorito, isDownloaded];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'hinos';
@override
VerificationContext validateIntegrity(Insertable<HinoData> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));}if (data.containsKey('numero')) {
context.handle(_numeroMeta, numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta));} else if (isInserting) {
context.missing(_numeroMeta);
}
if (data.containsKey('titulo')) {
context.handle(_tituloMeta, titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta));} else if (isInserting) {
context.missing(_tituloMeta);
}
if (data.containsKey('letra')) {
context.handle(_letraMeta, letra.isAcceptableOrUnknown(data['letra']!, _letraMeta));} else if (isInserting) {
context.missing(_letraMeta);
}
if (data.containsKey('autor')) {
context.handle(_autorMeta, autor.isAcceptableOrUnknown(data['autor']!, _autorMeta));}if (data.containsKey('audio_url')) {
context.handle(_audioUrlMeta, audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta));}if (data.containsKey('audio_local_path')) {
context.handle(_audioLocalPathMeta, audioLocalPath.isAcceptableOrUnknown(data['audio_local_path']!, _audioLocalPathMeta));}if (data.containsKey('is_favorito')) {
context.handle(_isFavoritoMeta, isFavorito.isAcceptableOrUnknown(data['is_favorito']!, _isFavoritoMeta));}if (data.containsKey('is_downloaded')) {
context.handle(_isDownloadedMeta, isDownloaded.isAcceptableOrUnknown(data['is_downloaded']!, _isDownloadedMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override HinoData map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return HinoData(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!, numero: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}numero'])!, titulo: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}titulo'])!, letra: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}letra'])!, autor: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}autor']), audioUrl: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}audio_url']), audioLocalPath: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}audio_local_path']), isFavorito: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_favorito'])!, isDownloaded: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_downloaded'])!, );
}
@override
$HinosTable createAlias(String alias) {
return $HinosTable(attachedDatabase, alias);}}class HinoData extends DataClass implements Insertable<HinoData> 
{
final int id;
final int numero;
final String titulo;
final String letra;
final String? autor;
final String? audioUrl;
final String? audioLocalPath;
final bool isFavorito;
final bool isDownloaded;
const HinoData({required this.id, required this.numero, required this.titulo, required this.letra, this.autor, this.audioUrl, this.audioLocalPath, required this.isFavorito, required this.isDownloaded});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<int>(id);
map['numero'] = Variable<int>(numero);
map['titulo'] = Variable<String>(titulo);
map['letra'] = Variable<String>(letra);
if (!nullToAbsent || autor != null){map['autor'] = Variable<String>(autor);
}if (!nullToAbsent || audioUrl != null){map['audio_url'] = Variable<String>(audioUrl);
}if (!nullToAbsent || audioLocalPath != null){map['audio_local_path'] = Variable<String>(audioLocalPath);
}map['is_favorito'] = Variable<bool>(isFavorito);
map['is_downloaded'] = Variable<bool>(isDownloaded);
return map; 
}
HinosCompanion toCompanion(bool nullToAbsent) {
return HinosCompanion(id: Value(id),numero: Value(numero),titulo: Value(titulo),letra: Value(letra),autor: autor == null && nullToAbsent ? const Value.absent() : Value(autor),audioUrl: audioUrl == null && nullToAbsent ? const Value.absent() : Value(audioUrl),audioLocalPath: audioLocalPath == null && nullToAbsent ? const Value.absent() : Value(audioLocalPath),isFavorito: Value(isFavorito),isDownloaded: Value(isDownloaded),);
}
factory HinoData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return HinoData(id: serializer.fromJson<int>(json['id']),numero: serializer.fromJson<int>(json['numero']),titulo: serializer.fromJson<String>(json['titulo']),letra: serializer.fromJson<String>(json['letra']),autor: serializer.fromJson<String?>(json['autor']),audioUrl: serializer.fromJson<String?>(json['audioUrl']),audioLocalPath: serializer.fromJson<String?>(json['audioLocalPath']),isFavorito: serializer.fromJson<bool>(json['isFavorito']),isDownloaded: serializer.fromJson<bool>(json['isDownloaded']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'numero': serializer.toJson<int>(numero),'titulo': serializer.toJson<String>(titulo),'letra': serializer.toJson<String>(letra),'autor': serializer.toJson<String?>(autor),'audioUrl': serializer.toJson<String?>(audioUrl),'audioLocalPath': serializer.toJson<String?>(audioLocalPath),'isFavorito': serializer.toJson<bool>(isFavorito),'isDownloaded': serializer.toJson<bool>(isDownloaded),};}HinoData copyWith({int? id,int? numero,String? titulo,String? letra,Value<String?> autor = const Value.absent(),Value<String?> audioUrl = const Value.absent(),Value<String?> audioLocalPath = const Value.absent(),bool? isFavorito,bool? isDownloaded}) => HinoData(id: id ?? this.id,numero: numero ?? this.numero,titulo: titulo ?? this.titulo,letra: letra ?? this.letra,autor: autor.present ? autor.value : this.autor,audioUrl: audioUrl.present ? audioUrl.value : this.audioUrl,audioLocalPath: audioLocalPath.present ? audioLocalPath.value : this.audioLocalPath,isFavorito: isFavorito ?? this.isFavorito,isDownloaded: isDownloaded ?? this.isDownloaded,);HinoData copyWithCompanion(HinosCompanion data) {
return HinoData(
id: data.id.present ? data.id.value : this.id,numero: data.numero.present ? data.numero.value : this.numero,titulo: data.titulo.present ? data.titulo.value : this.titulo,letra: data.letra.present ? data.letra.value : this.letra,autor: data.autor.present ? data.autor.value : this.autor,audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,audioLocalPath: data.audioLocalPath.present ? data.audioLocalPath.value : this.audioLocalPath,isFavorito: data.isFavorito.present ? data.isFavorito.value : this.isFavorito,isDownloaded: data.isDownloaded.present ? data.isDownloaded.value : this.isDownloaded,);
}
@override
String toString() {return (StringBuffer('HinoData(')..write('id: $id, ')..write('numero: $numero, ')..write('titulo: $titulo, ')..write('letra: $letra, ')..write('autor: $autor, ')..write('audioUrl: $audioUrl, ')..write('audioLocalPath: $audioLocalPath, ')..write('isFavorito: $isFavorito, ')..write('isDownloaded: $isDownloaded')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, numero, titulo, letra, autor, audioUrl, audioLocalPath, isFavorito, isDownloaded);@override
bool operator ==(Object other) => identical(this, other) || (other is HinoData && other.id == this.id && other.numero == this.numero && other.titulo == this.titulo && other.letra == this.letra && other.autor == this.autor && other.audioUrl == this.audioUrl && other.audioLocalPath == this.audioLocalPath && other.isFavorito == this.isFavorito && other.isDownloaded == this.isDownloaded);
}class HinosCompanion extends UpdateCompanion<HinoData> {
final Value<int> id;
final Value<int> numero;
final Value<String> titulo;
final Value<String> letra;
final Value<String?> autor;
final Value<String?> audioUrl;
final Value<String?> audioLocalPath;
final Value<bool> isFavorito;
final Value<bool> isDownloaded;
const HinosCompanion({this.id = const Value.absent(),this.numero = const Value.absent(),this.titulo = const Value.absent(),this.letra = const Value.absent(),this.autor = const Value.absent(),this.audioUrl = const Value.absent(),this.audioLocalPath = const Value.absent(),this.isFavorito = const Value.absent(),this.isDownloaded = const Value.absent(),});
HinosCompanion.insert({this.id = const Value.absent(),required int numero,required String titulo,required String letra,this.autor = const Value.absent(),this.audioUrl = const Value.absent(),this.audioLocalPath = const Value.absent(),this.isFavorito = const Value.absent(),this.isDownloaded = const Value.absent(),}): numero = Value(numero), titulo = Value(titulo), letra = Value(letra);
static Insertable<HinoData> custom({Expression<int>? id, 
Expression<int>? numero, 
Expression<String>? titulo, 
Expression<String>? letra, 
Expression<String>? autor, 
Expression<String>? audioUrl, 
Expression<String>? audioLocalPath, 
Expression<bool>? isFavorito, 
Expression<bool>? isDownloaded, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (numero != null)'numero': numero,if (titulo != null)'titulo': titulo,if (letra != null)'letra': letra,if (autor != null)'autor': autor,if (audioUrl != null)'audio_url': audioUrl,if (audioLocalPath != null)'audio_local_path': audioLocalPath,if (isFavorito != null)'is_favorito': isFavorito,if (isDownloaded != null)'is_downloaded': isDownloaded,});
}HinosCompanion copyWith({Value<int>? id, Value<int>? numero, Value<String>? titulo, Value<String>? letra, Value<String?>? autor, Value<String?>? audioUrl, Value<String?>? audioLocalPath, Value<bool>? isFavorito, Value<bool>? isDownloaded}) {
return HinosCompanion(id: id ?? this.id,numero: numero ?? this.numero,titulo: titulo ?? this.titulo,letra: letra ?? this.letra,autor: autor ?? this.autor,audioUrl: audioUrl ?? this.audioUrl,audioLocalPath: audioLocalPath ?? this.audioLocalPath,isFavorito: isFavorito ?? this.isFavorito,isDownloaded: isDownloaded ?? this.isDownloaded,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<int>(id.value);}
if (numero.present) {
map['numero'] = Variable<int>(numero.value);}
if (titulo.present) {
map['titulo'] = Variable<String>(titulo.value);}
if (letra.present) {
map['letra'] = Variable<String>(letra.value);}
if (autor.present) {
map['autor'] = Variable<String>(autor.value);}
if (audioUrl.present) {
map['audio_url'] = Variable<String>(audioUrl.value);}
if (audioLocalPath.present) {
map['audio_local_path'] = Variable<String>(audioLocalPath.value);}
if (isFavorito.present) {
map['is_favorito'] = Variable<bool>(isFavorito.value);}
if (isDownloaded.present) {
map['is_downloaded'] = Variable<bool>(isDownloaded.value);}
return map; 
}
@override
String toString() {return (StringBuffer('HinosCompanion(')..write('id: $id, ')..write('numero: $numero, ')..write('titulo: $titulo, ')..write('letra: $letra, ')..write('autor: $autor, ')..write('audioUrl: $audioUrl, ')..write('audioLocalPath: $audioLocalPath, ')..write('isFavorito: $isFavorito, ')..write('isDownloaded: $isDownloaded')..write(')')).toString();}
}
class $PalavraDicionariosTable extends PalavraDicionarios with TableInfo<$PalavraDicionariosTable, PalavraDicionarioData>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$PalavraDicionariosTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _palavraMeta = const VerificationMeta('palavra');
@override
late final GeneratedColumn<String> palavra = GeneratedColumn<String>('palavra', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _idiomaMeta = const VerificationMeta('idioma');
@override
late final GeneratedColumn<String> idioma = GeneratedColumn<String>('idioma', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _explicacaoMeta = const VerificationMeta('explicacao');
@override
late final GeneratedColumn<String> explicacao = GeneratedColumn<String>('explicacao', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _exemploUsoMeta = const VerificationMeta('exemploUso');
@override
late final GeneratedColumn<String> exemploUso = GeneratedColumn<String>('exemplo_uso', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _hinoIdRelacionadoMeta = const VerificationMeta('hinoIdRelacionado');
@override
late final GeneratedColumn<int> hinoIdRelacionado = GeneratedColumn<int>('hino_id_relacionado', aliasedName, true, type: DriftSqlType.int, requiredDuringInsert: false);
@override
List<GeneratedColumn> get $columns => [id, palavra, idioma, explicacao, exemploUso, hinoIdRelacionado];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'palavra_dicionarios';
@override
VerificationContext validateIntegrity(Insertable<PalavraDicionarioData> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));}if (data.containsKey('palavra')) {
context.handle(_palavraMeta, palavra.isAcceptableOrUnknown(data['palavra']!, _palavraMeta));} else if (isInserting) {
context.missing(_palavraMeta);
}
if (data.containsKey('idioma')) {
context.handle(_idiomaMeta, idioma.isAcceptableOrUnknown(data['idioma']!, _idiomaMeta));} else if (isInserting) {
context.missing(_idiomaMeta);
}
if (data.containsKey('explicacao')) {
context.handle(_explicacaoMeta, explicacao.isAcceptableOrUnknown(data['explicacao']!, _explicacaoMeta));}if (data.containsKey('exemplo_uso')) {
context.handle(_exemploUsoMeta, exemploUso.isAcceptableOrUnknown(data['exemplo_uso']!, _exemploUsoMeta));}if (data.containsKey('hino_id_relacionado')) {
context.handle(_hinoIdRelacionadoMeta, hinoIdRelacionado.isAcceptableOrUnknown(data['hino_id_relacionado']!, _hinoIdRelacionadoMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override PalavraDicionarioData map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return PalavraDicionarioData(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!, palavra: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}palavra'])!, idioma: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}idioma'])!, explicacao: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}explicacao']), exemploUso: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}exemplo_uso']), hinoIdRelacionado: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}hino_id_relacionado']), );
}
@override
$PalavraDicionariosTable createAlias(String alias) {
return $PalavraDicionariosTable(attachedDatabase, alias);}}class PalavraDicionarioData extends DataClass implements Insertable<PalavraDicionarioData> 
{
final int id;
final String palavra;
final String idioma;
final String? explicacao;
final String? exemploUso;
final int? hinoIdRelacionado;
const PalavraDicionarioData({required this.id, required this.palavra, required this.idioma, this.explicacao, this.exemploUso, this.hinoIdRelacionado});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<int>(id);
map['palavra'] = Variable<String>(palavra);
map['idioma'] = Variable<String>(idioma);
if (!nullToAbsent || explicacao != null){map['explicacao'] = Variable<String>(explicacao);
}if (!nullToAbsent || exemploUso != null){map['exemplo_uso'] = Variable<String>(exemploUso);
}if (!nullToAbsent || hinoIdRelacionado != null){map['hino_id_relacionado'] = Variable<int>(hinoIdRelacionado);
}return map; 
}
PalavraDicionariosCompanion toCompanion(bool nullToAbsent) {
return PalavraDicionariosCompanion(id: Value(id),palavra: Value(palavra),idioma: Value(idioma),explicacao: explicacao == null && nullToAbsent ? const Value.absent() : Value(explicacao),exemploUso: exemploUso == null && nullToAbsent ? const Value.absent() : Value(exemploUso),hinoIdRelacionado: hinoIdRelacionado == null && nullToAbsent ? const Value.absent() : Value(hinoIdRelacionado),);
}
factory PalavraDicionarioData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return PalavraDicionarioData(id: serializer.fromJson<int>(json['id']),palavra: serializer.fromJson<String>(json['palavra']),idioma: serializer.fromJson<String>(json['idioma']),explicacao: serializer.fromJson<String?>(json['explicacao']),exemploUso: serializer.fromJson<String?>(json['exemploUso']),hinoIdRelacionado: serializer.fromJson<int?>(json['hinoIdRelacionado']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'palavra': serializer.toJson<String>(palavra),'idioma': serializer.toJson<String>(idioma),'explicacao': serializer.toJson<String?>(explicacao),'exemploUso': serializer.toJson<String?>(exemploUso),'hinoIdRelacionado': serializer.toJson<int?>(hinoIdRelacionado),};}PalavraDicionarioData copyWith({int? id,String? palavra,String? idioma,Value<String?> explicacao = const Value.absent(),Value<String?> exemploUso = const Value.absent(),Value<int?> hinoIdRelacionado = const Value.absent()}) => PalavraDicionarioData(id: id ?? this.id,palavra: palavra ?? this.palavra,idioma: idioma ?? this.idioma,explicacao: explicacao.present ? explicacao.value : this.explicacao,exemploUso: exemploUso.present ? exemploUso.value : this.exemploUso,hinoIdRelacionado: hinoIdRelacionado.present ? hinoIdRelacionado.value : this.hinoIdRelacionado,);PalavraDicionarioData copyWithCompanion(PalavraDicionariosCompanion data) {
return PalavraDicionarioData(
id: data.id.present ? data.id.value : this.id,palavra: data.palavra.present ? data.palavra.value : this.palavra,idioma: data.idioma.present ? data.idioma.value : this.idioma,explicacao: data.explicacao.present ? data.explicacao.value : this.explicacao,exemploUso: data.exemploUso.present ? data.exemploUso.value : this.exemploUso,hinoIdRelacionado: data.hinoIdRelacionado.present ? data.hinoIdRelacionado.value : this.hinoIdRelacionado,);
}
@override
String toString() {return (StringBuffer('PalavraDicionarioData(')..write('id: $id, ')..write('palavra: $palavra, ')..write('idioma: $idioma, ')..write('explicacao: $explicacao, ')..write('exemploUso: $exemploUso, ')..write('hinoIdRelacionado: $hinoIdRelacionado')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, palavra, idioma, explicacao, exemploUso, hinoIdRelacionado);@override
bool operator ==(Object other) => identical(this, other) || (other is PalavraDicionarioData && other.id == this.id && other.palavra == this.palavra && other.idioma == this.idioma && other.explicacao == this.explicacao && other.exemploUso == this.exemploUso && other.hinoIdRelacionado == this.hinoIdRelacionado);
}class PalavraDicionariosCompanion extends UpdateCompanion<PalavraDicionarioData> {
final Value<int> id;
final Value<String> palavra;
final Value<String> idioma;
final Value<String?> explicacao;
final Value<String?> exemploUso;
final Value<int?> hinoIdRelacionado;
const PalavraDicionariosCompanion({this.id = const Value.absent(),this.palavra = const Value.absent(),this.idioma = const Value.absent(),this.explicacao = const Value.absent(),this.exemploUso = const Value.absent(),this.hinoIdRelacionado = const Value.absent(),});
PalavraDicionariosCompanion.insert({this.id = const Value.absent(),required String palavra,required String idioma,this.explicacao = const Value.absent(),this.exemploUso = const Value.absent(),this.hinoIdRelacionado = const Value.absent(),}): palavra = Value(palavra), idioma = Value(idioma);
static Insertable<PalavraDicionarioData> custom({Expression<int>? id, 
Expression<String>? palavra, 
Expression<String>? idioma, 
Expression<String>? explicacao, 
Expression<String>? exemploUso, 
Expression<int>? hinoIdRelacionado, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (palavra != null)'palavra': palavra,if (idioma != null)'idioma': idioma,if (explicacao != null)'explicacao': explicacao,if (exemploUso != null)'exemplo_uso': exemploUso,if (hinoIdRelacionado != null)'hino_id_relacionado': hinoIdRelacionado,});
}PalavraDicionariosCompanion copyWith({Value<int>? id, Value<String>? palavra, Value<String>? idioma, Value<String?>? explicacao, Value<String?>? exemploUso, Value<int?>? hinoIdRelacionado}) {
return PalavraDicionariosCompanion(id: id ?? this.id,palavra: palavra ?? this.palavra,idioma: idioma ?? this.idioma,explicacao: explicacao ?? this.explicacao,exemploUso: exemploUso ?? this.exemploUso,hinoIdRelacionado: hinoIdRelacionado ?? this.hinoIdRelacionado,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<int>(id.value);}
if (palavra.present) {
map['palavra'] = Variable<String>(palavra.value);}
if (idioma.present) {
map['idioma'] = Variable<String>(idioma.value);}
if (explicacao.present) {
map['explicacao'] = Variable<String>(explicacao.value);}
if (exemploUso.present) {
map['exemplo_uso'] = Variable<String>(exemploUso.value);}
if (hinoIdRelacionado.present) {
map['hino_id_relacionado'] = Variable<int>(hinoIdRelacionado.value);}
return map; 
}
@override
String toString() {return (StringBuffer('PalavraDicionariosCompanion(')..write('id: $id, ')..write('palavra: $palavra, ')..write('idioma: $idioma, ')..write('explicacao: $explicacao, ')..write('exemploUso: $exemploUso, ')..write('hinoIdRelacionado: $hinoIdRelacionado')..write(')')).toString();}
}
abstract class _$AppDatabase extends GeneratedDatabase{
_$AppDatabase(QueryExecutor e): super(e);
$AppDatabaseManager get managers => $AppDatabaseManager(this);
late final $HinosTable hinos = $HinosTable(this);
late final $PalavraDicionariosTable palavraDicionarios = $PalavraDicionariosTable(this);
@override
Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
@override
List<DatabaseSchemaEntity> get allSchemaEntities => [hinos, palavraDicionarios];
}
typedef $$HinosTableCreateCompanionBuilder = HinosCompanion Function({Value<int> id,required int numero,required String titulo,required String letra,Value<String?> autor,Value<String?> audioUrl,Value<String?> audioLocalPath,Value<bool> isFavorito,Value<bool> isDownloaded,});
typedef $$HinosTableUpdateCompanionBuilder = HinosCompanion Function({Value<int> id,Value<int> numero,Value<String> titulo,Value<String> letra,Value<String?> autor,Value<String?> audioUrl,Value<String?> audioLocalPath,Value<bool> isFavorito,Value<bool> isDownloaded,});
class $$HinosTableFilterComposer extends Composer<
        _$AppDatabase,
        $HinosTable> {
        $$HinosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get numero => $composableBuilder(
      column: $table.numero,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get titulo => $composableBuilder(
      column: $table.titulo,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get letra => $composableBuilder(
      column: $table.letra,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get autor => $composableBuilder(
      column: $table.autor,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get audioUrl => $composableBuilder(
      column: $table.audioUrl,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get audioLocalPath => $composableBuilder(
      column: $table.audioLocalPath,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<bool> get isFavorito => $composableBuilder(
      column: $table.isFavorito,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<bool> get isDownloaded => $composableBuilder(
      column: $table.isDownloaded,
      builder: (column) => 
      ColumnFilters(column));
      
        }
      class $$HinosTableOrderingComposer extends Composer<
        _$AppDatabase,
        $HinosTable> {
        $$HinosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get numero => $composableBuilder(
      column: $table.numero,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get titulo => $composableBuilder(
      column: $table.titulo,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get letra => $composableBuilder(
      column: $table.letra,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get autor => $composableBuilder(
      column: $table.autor,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get audioUrl => $composableBuilder(
      column: $table.audioUrl,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get audioLocalPath => $composableBuilder(
      column: $table.audioLocalPath,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<bool> get isFavorito => $composableBuilder(
      column: $table.isFavorito,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<bool> get isDownloaded => $composableBuilder(
      column: $table.isDownloaded,
      builder: (column) => 
      ColumnOrderings(column));
      
        }
      class $$HinosTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $HinosTable> {
        $$HinosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<int> get numero => $composableBuilder(
      column: $table.numero,
      builder: (column) => column);
      
GeneratedColumn<String> get titulo => $composableBuilder(
      column: $table.titulo,
      builder: (column) => column);
      
GeneratedColumn<String> get letra => $composableBuilder(
      column: $table.letra,
      builder: (column) => column);
      
GeneratedColumn<String> get autor => $composableBuilder(
      column: $table.autor,
      builder: (column) => column);
      
GeneratedColumn<String> get audioUrl => $composableBuilder(
      column: $table.audioUrl,
      builder: (column) => column);
      
GeneratedColumn<String> get audioLocalPath => $composableBuilder(
      column: $table.audioLocalPath,
      builder: (column) => column);
      
GeneratedColumn<bool> get isFavorito => $composableBuilder(
      column: $table.isFavorito,
      builder: (column) => column);
      
GeneratedColumn<bool> get isDownloaded => $composableBuilder(
      column: $table.isDownloaded,
      builder: (column) => column);
      
        }
      class $$HinosTableTableManager extends RootTableManager    <_$AppDatabase,
    $HinosTable,
    HinoData,
    $$HinosTableFilterComposer,
    $$HinosTableOrderingComposer,
    $$HinosTableAnnotationComposer,
    $$HinosTableCreateCompanionBuilder,
    $$HinosTableUpdateCompanionBuilder,
    (HinoData,BaseReferences<_$AppDatabase,$HinosTable,HinoData>),
    HinoData,
    PrefetchHooks Function()
    > {
    $$HinosTableTableManager(_$AppDatabase db, $HinosTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$HinosTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$HinosTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$HinosTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<int> id = const Value.absent(),Value<int> numero = const Value.absent(),Value<String> titulo = const Value.absent(),Value<String> letra = const Value.absent(),Value<String?> autor = const Value.absent(),Value<String?> audioUrl = const Value.absent(),Value<String?> audioLocalPath = const Value.absent(),Value<bool> isFavorito = const Value.absent(),Value<bool> isDownloaded = const Value.absent(),})=> HinosCompanion(id: id,numero: numero,titulo: titulo,letra: letra,autor: autor,audioUrl: audioUrl,audioLocalPath: audioLocalPath,isFavorito: isFavorito,isDownloaded: isDownloaded,),
        createCompanionCallback: ({Value<int> id = const Value.absent(),required int numero,required String titulo,required String letra,Value<String?> autor = const Value.absent(),Value<String?> audioUrl = const Value.absent(),Value<String?> audioLocalPath = const Value.absent(),Value<bool> isFavorito = const Value.absent(),Value<bool> isDownloaded = const Value.absent(),})=> HinosCompanion.insert(id: id,numero: numero,titulo: titulo,letra: letra,autor: autor,audioUrl: audioUrl,audioLocalPath: audioLocalPath,isFavorito: isFavorito,isDownloaded: isDownloaded,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), BaseReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback: null,
        ));
        }
    typedef $$HinosTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $HinosTable,
    HinoData,
    $$HinosTableFilterComposer,
    $$HinosTableOrderingComposer,
    $$HinosTableAnnotationComposer,
    $$HinosTableCreateCompanionBuilder,
    $$HinosTableUpdateCompanionBuilder,
    (HinoData,BaseReferences<_$AppDatabase,$HinosTable,HinoData>),
    HinoData,
    PrefetchHooks Function()
    >;typedef $$PalavraDicionariosTableCreateCompanionBuilder = PalavraDicionariosCompanion Function({Value<int> id,required String palavra,required String idioma,Value<String?> explicacao,Value<String?> exemploUso,Value<int?> hinoIdRelacionado,});
typedef $$PalavraDicionariosTableUpdateCompanionBuilder = PalavraDicionariosCompanion Function({Value<int> id,Value<String> palavra,Value<String> idioma,Value<String?> explicacao,Value<String?> exemploUso,Value<int?> hinoIdRelacionado,});
class $$PalavraDicionariosTableFilterComposer extends Composer<
        _$AppDatabase,
        $PalavraDicionariosTable> {
        $$PalavraDicionariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get palavra => $composableBuilder(
      column: $table.palavra,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get idioma => $composableBuilder(
      column: $table.idioma,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get explicacao => $composableBuilder(
      column: $table.explicacao,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get exemploUso => $composableBuilder(
      column: $table.exemploUso,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get hinoIdRelacionado => $composableBuilder(
      column: $table.hinoIdRelacionado,
      builder: (column) => 
      ColumnFilters(column));
      
        }
      class $$PalavraDicionariosTableOrderingComposer extends Composer<
        _$AppDatabase,
        $PalavraDicionariosTable> {
        $$PalavraDicionariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get palavra => $composableBuilder(
      column: $table.palavra,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get idioma => $composableBuilder(
      column: $table.idioma,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get explicacao => $composableBuilder(
      column: $table.explicacao,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get exemploUso => $composableBuilder(
      column: $table.exemploUso,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get hinoIdRelacionado => $composableBuilder(
      column: $table.hinoIdRelacionado,
      builder: (column) => 
      ColumnOrderings(column));
      
        }
      class $$PalavraDicionariosTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $PalavraDicionariosTable> {
        $$PalavraDicionariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get palavra => $composableBuilder(
      column: $table.palavra,
      builder: (column) => column);
      
GeneratedColumn<String> get idioma => $composableBuilder(
      column: $table.idioma,
      builder: (column) => column);
      
GeneratedColumn<String> get explicacao => $composableBuilder(
      column: $table.explicacao,
      builder: (column) => column);
      
GeneratedColumn<String> get exemploUso => $composableBuilder(
      column: $table.exemploUso,
      builder: (column) => column);
      
GeneratedColumn<int> get hinoIdRelacionado => $composableBuilder(
      column: $table.hinoIdRelacionado,
      builder: (column) => column);
      
        }
      class $$PalavraDicionariosTableTableManager extends RootTableManager    <_$AppDatabase,
    $PalavraDicionariosTable,
    PalavraDicionarioData,
    $$PalavraDicionariosTableFilterComposer,
    $$PalavraDicionariosTableOrderingComposer,
    $$PalavraDicionariosTableAnnotationComposer,
    $$PalavraDicionariosTableCreateCompanionBuilder,
    $$PalavraDicionariosTableUpdateCompanionBuilder,
    (PalavraDicionarioData,BaseReferences<_$AppDatabase,$PalavraDicionariosTable,PalavraDicionarioData>),
    PalavraDicionarioData,
    PrefetchHooks Function()
    > {
    $$PalavraDicionariosTableTableManager(_$AppDatabase db, $PalavraDicionariosTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$PalavraDicionariosTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$PalavraDicionariosTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$PalavraDicionariosTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<int> id = const Value.absent(),Value<String> palavra = const Value.absent(),Value<String> idioma = const Value.absent(),Value<String?> explicacao = const Value.absent(),Value<String?> exemploUso = const Value.absent(),Value<int?> hinoIdRelacionado = const Value.absent(),})=> PalavraDicionariosCompanion(id: id,palavra: palavra,idioma: idioma,explicacao: explicacao,exemploUso: exemploUso,hinoIdRelacionado: hinoIdRelacionado,),
        createCompanionCallback: ({Value<int> id = const Value.absent(),required String palavra,required String idioma,Value<String?> explicacao = const Value.absent(),Value<String?> exemploUso = const Value.absent(),Value<int?> hinoIdRelacionado = const Value.absent(),})=> PalavraDicionariosCompanion.insert(id: id,palavra: palavra,idioma: idioma,explicacao: explicacao,exemploUso: exemploUso,hinoIdRelacionado: hinoIdRelacionado,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), BaseReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback: null,
        ));
        }
    typedef $$PalavraDicionariosTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $PalavraDicionariosTable,
    PalavraDicionarioData,
    $$PalavraDicionariosTableFilterComposer,
    $$PalavraDicionariosTableOrderingComposer,
    $$PalavraDicionariosTableAnnotationComposer,
    $$PalavraDicionariosTableCreateCompanionBuilder,
    $$PalavraDicionariosTableUpdateCompanionBuilder,
    (PalavraDicionarioData,BaseReferences<_$AppDatabase,$PalavraDicionariosTable,PalavraDicionarioData>),
    PalavraDicionarioData,
    PrefetchHooks Function()
    >;class $AppDatabaseManager {
final _$AppDatabase _db;
$AppDatabaseManager(this._db);
$$HinosTableTableManager get hinos => $$HinosTableTableManager(_db, _db.hinos);
$$PalavraDicionariosTableTableManager get palavraDicionarios => $$PalavraDicionariosTableTableManager(_db, _db.palavraDicionarios);
}
