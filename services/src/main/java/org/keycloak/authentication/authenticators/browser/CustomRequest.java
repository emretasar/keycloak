package org.keycloak.authentication.authenticators.browser;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class CustomRequest {

    private static final String POST_URL = "https://www.belgenet.com.tr/mobil-imza-service/mobilImzaLogin";

    public static boolean sendHttpPOSTRequest(String postParamKonu, String postParamOperator, String postParamTel, String postParamTC) throws IOException {

        String requestBody = String.format("{\"konu\":\"%s\",\"operator\":\"%s\",\"telNo\":\"%s\",\"tcKimlikNo\":\"%s\"}",
                postParamKonu, postParamOperator, postParamTel, postParamTC);

        boolean success = false;

        try {
            URL url = new URL(POST_URL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setDoOutput(true);

            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = requestBody.getBytes("utf-8");
                os.write(input, 0, input.length);
            }
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"))) {
                    String responseLine;
                    StringBuilder response = new StringBuilder();
                    while ((responseLine = br.readLine()) != null) {
                        response.append(responseLine.trim());
                    }
                    System.out.println("Response: " + response.toString());
                    if (response.substring(12, 16).equals("true")) {
                        success = true;
                    }

                }

            } else {
                System.out.println("HTTP request failed with response code: " + responseCode);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return success;
    }
}
