package com.shoe.util;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;
import java.util.Base64;

public class TripleDESEncoder {
    private static final String key = "123456789012345678901234"; // 24-byte key for Triple DES

    // Method to encrypt a string using Triple DES
    public static String encrypt(String data) {
        try {
            // Convert the key string to bytes
            byte[] keyBytes = key.getBytes();
            // Create a DESedeKeySpec object from the key bytes
            DESedeKeySpec keySpec = new DESedeKeySpec(keyBytes);
            // Get a SecretKeyFactory instance for the Triple DES algorithm
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DESede");
            // Generate a SecretKey from the keySpec
            SecretKey secretKey = keyFactory.generateSecret(keySpec);
            // Get a Cipher instance for the Triple DES algorithm
            Cipher cipher = Cipher.getInstance("DESede");
            // Initialize the cipher for encryption using the secret key
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            // Encrypt the data bytes using the cipher
            byte[] encryptedBytes = cipher.doFinal(data.getBytes());
            // Encode the encrypted bytes to a string using Base64 and return it
            return Base64.getUrlEncoder().withoutPadding().encodeToString(encryptedBytes);
        } catch (Exception e) {
            // Print the stack trace for any exceptions
            e.printStackTrace();
        }
        // Return null if an exception occurred
        return null;
    }

    // Method to decrypt a string using Triple DES
    public static String decrypt(String encryptedData) {
        try {
            // Convert the key string to bytes
            byte[] keyBytes = key.getBytes();
            // Create a DESedeKeySpec object from the key bytes
            DESedeKeySpec keySpec = new DESedeKeySpec(keyBytes);
            // Get a SecretKeyFactory instance for the Triple DES algorithm
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DESede");
            // Generate a SecretKey from the keySpec
            SecretKey secretKey = keyFactory.generateSecret(keySpec);
            // Get a Cipher instance for the Triple DES algorithm
            Cipher cipher = Cipher.getInstance("DESede");
            // Initialize the cipher for decryption using the secret key
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            // Decode the encrypted data from Base64 to bytes
            byte[] decryptedBytes = cipher.doFinal(Base64.getUrlDecoder().decode(encryptedData));
            // Convert the decrypted bytes to a string and return it
            return new String(decryptedBytes);
        } catch (Exception e) {
            // Print the stack trace for any exceptions
            e.printStackTrace();
        }
        // Return null if an exception occurred
        return null;
    }

}
