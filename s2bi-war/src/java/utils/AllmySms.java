/*    */ package utils;
/*    */ 
/*    */ import java.io.InputStream;
/*    */ import java.io.PrintStream;
/*    */ import java.net.URL;
/*    */ import java.net.URLConnection;
/*    */ import java.net.URLEncoder;
/*    */ 
/*    */ public class AllmySms
/*    */ {
/* 17 */   private String phoneNumber = "";
/* 18 */   private String sender = "CTNPBF";
/* 19 */   private String message = "";
/*    */ 
/*    */   public AllmySms(String numero, String message) {
/* 22 */     this.phoneNumber = ("+237" + numero);
/* 23 */     this.message = message;
/*    */   }
/*    */ 
/*    */   public void send()
/*    */   {
/*    */     try {
/* 29 */       this.message = URLEncoder.encode(this.message, "UTF-8");
/* 30 */       String login = "batrapi";
/* 31 */       String apiKey = "njuomshetku";
/* 32 */       String smsData = "<DATA><MESSAGE><![CDATA[[" + this.message + "]]></MESSAGE><TPOA>" + this.sender + "</TPOA><SMS><MOBILEPHONE>" + this.phoneNumber + "</MOBILEPHONE></SMS></DATA>";
/*    */ 
/* 34 */       String url = "https://api.allmysms.com/http/9.0/sendSms/?login=" + login + "&apiKey=" + apiKey + "&smsData=" + smsData;
/*    */ 
/* 36 */       URL client = new URL(url);
/* 37 */       URLConnection conn = client.openConnection();
/* 38 */       InputStream responseBody = conn.getInputStream();
/*    */ 
/* 41 */       byte[] contents = new byte[1024];
/*    */ 
/* 43 */       int bytesRead = 0;
/* 44 */       String strFileContents = null;
/* 45 */       while ((bytesRead = responseBody.read(contents)) != -1) {
/* 46 */         strFileContents = new String(contents, 0, bytesRead);
/*    */       }
/*    */ 
/* 49 */       responseBody.close();
/* 50 */       System.out.println(strFileContents);
/*    */     } catch (Exception e) {
/* 52 */       e.printStackTrace();
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Users\kenne gervais\Desktop\alert\Alerte_numerique\Alerte_numerique-war\WEB-INF\classes\
 * Qualified Name:     utils.AllmySms
 * JD-Core Version:    0.6.2
 */