<%@ page import="file.FileDAO"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>U-CAMPUS</title>
</head>
<body>
	<%
	 String sectionName = null;

		String directory = "C:/Users/User/eclipse-workspace/upload";
		int maxSize = 1024 * 1024* 100;
		String encoding = "UTF-8";
	
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, maxSize, encoding,
				new DefaultFileRenamePolicy());
		sectionName=multipartRequest.getParameter("sectionName");
		Enumeration fileNames = multipartRequest.getFileNames();
		while(fileNames.hasMoreElements()) {
			String parameter = (String)fileNames.nextElement();
			String fileName = multipartRequest.getOriginalFileName(parameter);
			String fileRealName = multipartRequest.getFilesystemName(parameter);
			
			if(fileName==null) continue;
			
			if(!fileName.endsWith(".doc") && !fileName.endsWith(".docx") && !fileName.endsWith(".hwp") &&
					!fileName.endsWith(".pdf") && !fileName.endsWith(".txt")) {
				File file = new File(directory + fileRealName);
				file.delete();
				out.write("업로드할 수 없는 확장자입니다.");
				%><script>
				location.href = 'ucamsub.jsp';
			</script>
			<%
			} else {
				String text=multipartRequest.getParameter("text");
				new FileDAO().upload(fileName, fileRealName,text,sectionName);
				System.out.println(fileName+fileRealName+text+sectionName);
				%>
				</form>
						<form method="post" action="ucamsub.jsp">
						<input type="hidden"  action="lectureData.jsp" name="sectionName" value=<%=sectionName%>>
						 
						</form>
				<script>
				location.href = 'lectureData.jsp';
				</script>
			<%
			}
			
		}
	
	%>
</body>
</html>