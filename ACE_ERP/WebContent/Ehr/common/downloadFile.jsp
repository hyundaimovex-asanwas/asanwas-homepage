<%@ page contentType="application/text/html; charset=euc-kr"
         import="java.io.File,common.util.FileUtil" %><%

    response.reset();

    String fileName = request.getParameter("FILE_NAME");
    String fileUrl  = request.getParameter("FILE_URL");

    String strClient = request.getHeader("User-Agent");
    String ls_UserId = (String)request.getSession().getAttribute("SESSION_ENONO");

    try {
    	if ((ls_UserId == null) || (ls_UserId == "")) {
    		throw new Exception("사용권한이 없습니다.  정상적인 로그인 후 사용바랍니다.");
    	}
        if(fileName.equals("passwd.txt")) {

        	throw new Exception("파일이 존재하지 않거나 읽을수 없습니다");
        }

        if(strClient.indexOf("MSIE 5.5")>-1) {
            response.setHeader("Content-Type", "application/x-msdownload");
            response.setHeader("Content-Disposition", "filename="+fileName+";");
        }else {
            response.setHeader("Content-Type", "application/x-msdownload");
            response.setHeader("Content-Disposition", "attachment; filename="+fileName+";");
        }



        File readFile = new File(fileUrl);

        //파일이 존재하지 않거나 읽을 수 없으면 에러
        if (!readFile.exists() || !readFile.canRead()) throw new Exception("파일이 존재하지 않거나 읽을수 없습니다");


        //반환할 스트림
        javax.servlet.ServletOutputStream
                    servletoutputstream
                                = response.getOutputStream();

        //스트림에 기록
        FileUtil.writeOutputStream(servletoutputstream, readFile);

        //보내고 닫음
        servletoutputstream.flush();
        servletoutputstream.close();

    }catch(Exception e){
        //response.setContentType("text/html");
        out.println("Error : "+e.getMessage());
    }
%>