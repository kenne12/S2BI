/*     */ package utils;
/*     */ 
/*     */ import java.io.BufferedReader;
/*     */ import java.io.DataOutputStream;
/*     */ import java.io.InputStreamReader;
/*     */ import java.io.PrintStream;
/*     */ import java.net.HttpURLConnection;
/*     */ import java.net.URL;
/*     */ import java.net.URLEncoder;
/*     */ 
/*     */ public class Sender
/*     */ {
/*     */   String username;
/*     */   String password;
/*     */   String message;
/*     */   String type;
/*     */   String dlr;
/*     */   String destination;
/*     */   String source;
/*     */   String server;
/*     */   int port;
/*     */ 
/*     */   public Sender(String server, int port, String username, String password, String message, String dlr, String type, String destination, String source)
/*     */   {
/*  70 */     this.username = username;
/*  71 */     this.password = password;
/*  72 */     this.message = message;
/*  73 */     this.dlr = dlr;
/*  74 */     this.type = type;
/*  75 */     this.destination = destination;
/*  76 */     this.source = source;
/*  77 */     this.server = server;
/*  78 */     this.port = port;
/*     */   }
/*     */ 
/*     */   public void submitMessage()
/*     */   {
/*     */     try {
/*  84 */       URL sendUrl = new URL("http://" + this.server + ":" + this.port + "/bulksms/bulksms");
/*  85 */       HttpURLConnection httpConnection = (HttpURLConnection)sendUrl.openConnection();
/*     */ 
/*  88 */       httpConnection.setRequestMethod("POST");
/*     */ 
/*  91 */       httpConnection.setDoInput(true);
/*     */ 
/*  93 */       httpConnection.setDoOutput(true);
/*     */ 
/*  95 */       httpConnection.setUseCaches(false);
/*     */ 
/*  97 */       DataOutputStream dataStreamToServer = new DataOutputStream(httpConnection.getOutputStream());
/*  98 */       dataStreamToServer.writeBytes("username=" + 
/*  99 */         URLEncoder.encode(this.username, "UTF-8") + 
/*  99 */         "&password=" + 
/* 100 */         URLEncoder.encode(this.password, "UTF-8") + 
/* 100 */         "&type=" + 
/* 101 */         URLEncoder.encode(this.type, "UTF-8") + 
/* 101 */         "&dlr=" + 
/* 102 */         URLEncoder.encode(this.dlr, "UTF-8") + 
/* 102 */         "&destination=" + 
/* 103 */         URLEncoder.encode(this.destination, "UTF-8") + 
/* 103 */         "&source=" + 
/* 104 */         URLEncoder.encode(this.source, "UTF-8") + 
/* 104 */         "&message=" + 
/* 105 */         URLEncoder.encode(this.message, "UTF-8"));
/*     */ 
/* 106 */       dataStreamToServer.flush();
/* 107 */       dataStreamToServer.close();
/*     */ 
/* 109 */       BufferedReader dataStreamFromUrl = new BufferedReader(new InputStreamReader(httpConnection.getInputStream()));
/* 110 */       String dataFromUrl = ""; String dataBuffer = "";
/*     */ 
/* 112 */       while ((dataBuffer = dataStreamFromUrl.readLine()) != null) {
/* 113 */         dataFromUrl = dataFromUrl + dataBuffer;
/*     */       }
/*     */ 
/* 119 */       dataStreamFromUrl.close();
/* 120 */       System.out.println("Response: " + dataFromUrl);
/*     */     } catch (Exception ex) {
/* 122 */       ex.printStackTrace();
/*     */     }
/*     */   }
/*     */ 
/*     */   public static StringBuffer convertToUnicode(String regText)
/*     */   {
/* 133 */     char[] chars = regText.toCharArray();
/* 134 */     StringBuffer hexString = new StringBuffer();
/* 135 */     for (int i = 0; i < chars.length; i++) {
/* 136 */       String iniHexString = Integer.toHexString(chars[i]);
/* 137 */       if (iniHexString.length() == 1)
/* 138 */         iniHexString = "000" + iniHexString;
/* 139 */       else if (iniHexString.length() == 2) {
/* 140 */         iniHexString = "00" + iniHexString;
/*     */       }
/* 142 */       else if (iniHexString.length() == 3) {
/* 143 */         iniHexString = "0" + iniHexString;
/*     */       }
/*     */ 
/* 146 */       hexString.append(iniHexString);
/*     */     }
/* 148 */     System.out.println(hexString);
/* 149 */     return hexString;
/*     */   }
/*     */ }

/* Location:           C:\Users\kenne gervais\Desktop\alert\Alerte_numerique\Alerte_numerique-war\WEB-INF\classes\
 * Qualified Name:     utils.Sender
 * JD-Core Version:    0.6.2
 */