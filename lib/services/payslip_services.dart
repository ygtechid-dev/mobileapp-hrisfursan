part of 'services.dart';

class PayslipServices {

  static Future<ApiReturnValue<List<Payslip>>> getListPayslip(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/payslip';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);

    print("List Category " + response.body.toString());

    List<Payslip> value = (data['data']['payslips'] as Iterable)
        .map((e) => Payslip.fromJson(e))
        .toList();

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<Payslip>> getPayslipDetail(String token, String payslip_id, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/payslip/${payslip_id}';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);

    print(response.body.toString());

    Payslip value = Payslip.fromJson(data["data"]);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<PayslipExport>> getPayslipPdf(String token, String payslip_id, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/payslip/${payslip_id}/export-pdf';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);

    print(response.body.toString());

    PayslipExport value = PayslipExport.fromJson(data["data"]);

    return ApiReturnValue(value: value);
  }

}