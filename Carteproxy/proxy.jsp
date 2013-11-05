<%@ page
    import="java.io.*,
            java.util.*,
            java.net.*"
    contentType="text/plain; charset=UTF-8"
%><%
StringBuffer sbf = new StringBuffer();
//Access the page
try {
  // Add additional parameters to the requested url
  String requestedUrl = request.getParameter("url");
  Map<String,String> additionalParameters = request.getParameterMap();
  Iterator parameterIterator = additionalParameters.keySet().iterator();
  while( parameterIterator.hasNext() ) {
    String nextParamName = (String) parameterIterator.next();
    // no need to repeat "url" as this is our first and really mandatory request parameter
    if ( !"url".equals(nextParamName) ) {
      requestedUrl += "&"+nextParamName+"="+request.getParameter(nextParamName);
    }
  }
  requestedUrl = requestedUrl.replace(" ","+");
  URL url = new URL(requestedUrl);
  HttpURLConnection conn=(HttpURLConnection)url.openConnection();
  conn.setRequestMethod("GET");
  String authHeaderValue = "Basic Y2x1c3RlcjpjbHVzdGVy";
  conn.setRequestProperty("Authorization",authHeaderValue);
  // Copy the proxied content-type to own response
  response.setContentType(conn.getContentType());
  BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
  String inputLine;
  while ( (inputLine = in.readLine()) != null) {
    sbf.append(inputLine);
  }
  in.close();
} catch (MalformedURLException e) {
} catch (IOException e) {
}
%><%= sbf.toString()%>