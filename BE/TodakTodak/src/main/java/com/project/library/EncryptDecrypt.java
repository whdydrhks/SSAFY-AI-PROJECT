package com.project.library;

import java.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import org.springframework.stereotype.Component;

@Component
public class EncryptDecrypt {
    
    public String loadKey() {
        return "encryptionKey123";
    }
    
    public String loadInitVector() {
        return "encryptionIntVec";
    }
    
    public String encrypt(String plainText) {
        try {
            IvParameterSpec iv      = new IvParameterSpec(loadInitVector().getBytes("UTF-8"));
            SecretKeySpec   keySpec = new SecretKeySpec(loadKey().getBytes("UTF-8"), "AES");
            Cipher          cipher  = Cipher.getInstance("AES/CBC/PKCS5PADDING");
            cipher.init(Cipher.ENCRYPT_MODE, keySpec, iv);
            byte[] encrypted = cipher.doFinal(plainText.getBytes());
            return Base64.getEncoder().encodeToString(encrypted);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public String decrypt(String encryptedText) {
        try {
            IvParameterSpec iv      = new IvParameterSpec(loadInitVector().getBytes("UTF-8"));
            SecretKeySpec   keySpec = new SecretKeySpec(loadKey().getBytes("UTF-8"), "AES");
            Cipher          cipher  = Cipher.getInstance("AES/CBC/PKCS5PADDING");
            cipher.init(Cipher.DECRYPT_MODE, keySpec, iv);
            byte[] original = cipher.doFinal(Base64.getDecoder().decode(encryptedText));
            return new String(original);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
}
