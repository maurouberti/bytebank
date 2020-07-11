import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:bytebank/http/webclients/transacao_webclient.dart';
import 'package:mockito/mockito.dart';

class MockContatoDao extends Mock implements ContatoDao {}
class MockTransacaoWebClient extends Mock implements TransacaoWebClient {}