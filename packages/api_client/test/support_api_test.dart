import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for SupportApi
void main() {
  final instance = ApiClient().getSupportApi();

  group(SupportApi, () {
    // Create a support ticket
    //
    //Future supportControllerCreateTicket(CreateTicketDto createTicketDto) async
    test('test supportControllerCreateTicket', () async {
      // TODO
    });

    // Get all support tickets
    //
    //Future supportControllerGetAllTickets({ num page, num limit, String cursor, String status, String priority, String assignedTo }) async
    test('test supportControllerGetAllTickets', () async {
      // TODO
    });

    // Get my support tickets
    //
    //Future supportControllerGetMyTickets({ num page, num limit, String cursor }) async
    test('test supportControllerGetMyTickets', () async {
      // TODO
    });

    // Get a specific ticket
    //
    //Future supportControllerGetTicketById(String id) async
    test('test supportControllerGetTicketById', () async {
      // TODO
    });

    // Update a ticket
    //
    //Future supportControllerUpdateTicket(String id, UpdateTicketDto updateTicketDto) async
    test('test supportControllerUpdateTicket', () async {
      // TODO
    });

  });
}
