---
title: CN-Assin_6
date: 2026-09-28
tags:
---

# Server
```java
import java.io.*;
import java.net.*;

public class Server {

    public static void main(String[] args) {

        try {
            ServerSocket serverSocket = new ServerSocket(3333);

            System.out.println("Server started...");
            System.out.println("Waiting for client...");

            Socket socket = serverSocket.accept();

            System.out.println("Client connected!");

            DataInputStream input =
                    new DataInputStream(socket.getInputStream());

            DataOutputStream output =
                    new DataOutputStream(socket.getOutputStream());

            BufferedReader reader =
                    new BufferedReader(new InputStreamReader(System.in));

            while (true) {

                // Receive choice from client
                int choice = input.readInt();

                // Exit
                if (choice == 0) {
                    System.out.println("Client disconnected.");
                    break;
                }

                // 1. Say Hello to each other
                if (choice == 1) {

                    // Receive hello from client
                    String clientMessage = input.readUTF();

                    System.out.println("Client: " + clientMessage);

                    // Send hello to client
                    System.out.print("Enter message to client: ");
                    String serverMessage = reader.readLine();

                    output.writeUTF(serverMessage);
                    output.flush();
                }

                // 2. File Transfer
                else if (choice == 2) {

                    String fileName = input.readUTF();
                    long fileSize = input.readLong();

                    File folder = new File("received_files");

                    if (!folder.exists()) {
                        folder.mkdir();
                    }

                    FileOutputStream fileOutput =
                            new FileOutputStream(
                                    "received_files/" + fileName
                            );

                    byte[] buffer = new byte[4096];

                    while (fileSize > 0) {

                        int bytes = input.read(
                                buffer,
                                0,
                                (int) Math.min(buffer.length, fileSize)
                        );

                        if (bytes == -1)
                            break;

                        fileOutput.write(buffer, 0, bytes);

                        fileSize -= bytes;
                    }

                    fileOutput.close();

                    System.out.println(
                            "File received: " + fileName
                    );

                    output.writeUTF(
                            "File received successfully."
                    );

                    output.flush();
                }

                // 3. Arithmetic Calculator
                else if (choice == 3) {

                    double a = input.readDouble();
                    String operator = input.readUTF();
                    double b = input.readDouble();

                    String result;

                    if (operator.equals("+")) {
                        result = String.valueOf(a + b);
                    }

                    else if (operator.equals("-")) {
                        result = String.valueOf(a - b);
                    }

                    else if (operator.equals("*")) {
                        result = String.valueOf(a * b);
                    }

                    else if (operator.equals("/")) {

                        if (b == 0)
                            result = "Error: Division by zero";

                        else
                            result = String.valueOf(a / b);
                    }

                    else {
                        result = "Error: Invalid operator";
                    }

                    output.writeUTF("Result = " + result);
                    output.flush();
                }

                // 4. Trigonometry Calculator
                else if (choice == 4) {

                    String function = input.readUTF();
                    double angle = input.readDouble();

                    double radians = Math.toRadians(angle);

                    String result;

                    if (function.equals("sin")) {

                        result = String.valueOf(
                                Math.sin(radians)
                        );
                    }

                    else if (function.equals("cos")) {

                        result = String.valueOf(
                                Math.cos(radians)
                        );
                    }

                    else if (function.equals("tan")) {

                        result = String.valueOf(
                                Math.tan(radians)
                        );
                    }

                    else {
                        result = "Error: Invalid function";
                    }

                    output.writeUTF("Result = " + result);
                    output.flush();
                }

                else {

                    output.writeUTF("Invalid choice");
                    output.flush();
                }
            }

            socket.close();
            serverSocket.close();

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}

```

# Client
```java
import java.io.*;
import java.net.*;

public class Client {

    public static void main(String[] args) {

        try {

            Socket socket = new Socket("localhost", 3333);

            DataInputStream input =
                    new DataInputStream(socket.getInputStream());

            DataOutputStream output =
                    new DataOutputStream(socket.getOutputStream());

            BufferedReader reader =
                    new BufferedReader(
                            new InputStreamReader(System.in)
                    );

            while (true) {

                System.out.println("\n===== MENU =====");
                System.out.println("1. Say Hello");
                System.out.println("2. File Transfer");
                System.out.println("3. Arithmetic Calculator");
                System.out.println("4. Trigonometry Calculator");
                System.out.println("0. Exit");

                System.out.print("Enter choice: ");

                int choice =
                        Integer.parseInt(reader.readLine());

                // Send choice to server
                output.writeInt(choice);
                output.flush();

                // Exit
                if (choice == 0) {
                    break;
                }

                // 1. Say Hello
                if (choice == 1) {

                    // Send message to server
                    System.out.print("Enter message: ");
                    String message = reader.readLine();

                    output.writeUTF(message);
                    output.flush();

                    // Receive message from server
                    String reply = input.readUTF();

                    System.out.println("Server: " + reply);
                }

                // 2. File Transfer
                else if (choice == 2) {

                    System.out.print("Enter file path: ");
                    String path = reader.readLine();

                    File file = new File(path);

                    if (!file.exists()) {
                        System.out.println("File not found!");
                        continue;
                    }

                    // Send file name
                    output.writeUTF(file.getName());

                    // Send file size
                    output.writeLong(file.length());

                    // Send file data
                    FileInputStream fileInput =
                            new FileInputStream(file);

                    byte[] buffer = new byte[4096];

                    int bytes;

                    while ((bytes = fileInput.read(buffer)) != -1) {

                        output.write(buffer, 0, bytes);
                    }

                    output.flush();

                    fileInput.close();

                    // Receive confirmation
                    System.out.println(
                            "Server: " + input.readUTF()
                    );
                }

                // 3. Arithmetic Calculator
                else if (choice == 3) {

                    System.out.print("Enter first number: ");
                    double a =
                            Double.parseDouble(reader.readLine());

                    System.out.print(
                            "Enter operator (+, -, *, /): "
                    );

                    String operator = reader.readLine();

                    System.out.print("Enter second number: ");
                    double b =
                            Double.parseDouble(reader.readLine());

                    // Send data
                    output.writeDouble(a);
                    output.writeUTF(operator);
                    output.writeDouble(b);
                    output.flush();

                    // Receive result
                    System.out.println(
                            "Server: " + input.readUTF()
                    );
                }

                // 4. Trigonometry Calculator
                else if (choice == 4) {

                    System.out.print(
                            "Enter function (sin/cos/tan): "
                    );

                    String function = reader.readLine();

                    System.out.print(
                            "Enter angle in degrees: "
                    );

                    double angle =
                            Double.parseDouble(reader.readLine());

                    // Send data
                    output.writeUTF(function);
                    output.writeDouble(angle);
                    output.flush();

                    // Receive result
                    System.out.println(
                            "Server: " + input.readUTF()
                    );
                }
            }

            socket.close();

        } catch (Exception e) {

            System.out.println("Error: " + e.getMessage());
        }
    }
}
```