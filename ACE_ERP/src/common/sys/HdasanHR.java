package common.sys;
/*
 * [ �������� ][������] ����   
 * [2011-12-13][�ɵ���] ũ�ν� �������� �����ϱ� ���� �������� �о �ٽ� ��
 * */
import com.octo.captcha.service.CaptchaServiceException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.*;
import javax.servlet.http.*;

public class HdasanHR extends HttpServlet {

	public String getHttpData(String httpURL, String parameter) throws Exception { 
		byte buffer[] = new byte[2048]; 
		StringBuffer recvData = new StringBuffer(); 

		//	   ��������� ���� 
		URL url = new URL(httpURL); 
		URLConnection conn = (HttpURLConnection) url.openConnection(); 
		conn.setDoOutput(true); 
		conn.setUseCaches(false); 

		//	   ��������� ���� 
		OutputStream out = conn.getOutputStream(); 
		BufferedOutputStream bout = new BufferedOutputStream(out); 
		if ((parameter != null) || (parameter.length() > 0)) 
		bout.write(parameter.getBytes()); 
		bout.flush(); 
		bout.close(); 
		out.close(); 

	//	   �������� ���÷��� ������ ���� 
		InputStream in = conn.getInputStream(); 
		BufferedInputStream bin = new BufferedInputStream(in); 
		while (bin.read(buffer) > 0) { 
		recvData.append(new String(buffer, "EUC-KR")); 
		} 
		bin.close(); 
		in.close(); 

		//System.out.println(recvData.toString().trim());
		return recvData.toString().trim();
	} 


	protected void doGet( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException
	{
		String cnt 	= "100";
	  	String empno= request.getParameter("empno");
		
		//System.out.println("������==="+cnt);
		
		String inURL = "http://ehr.hdasan.com/servlets/common.groupware.GroupWareServlet?ENO_NO="+empno; 
				 		
		try {
			HdasanHR HdasanHR = new HdasanHR(); 
			cnt = getHttpData( inURL, "" );
			//System.out.println("���� ��==="+cnt);
			PrintWriter out = response.getWriter();
			response.setContentType("text/html;charset=euc-kr");			
			out.println(cnt);
			return;
		}catch( Exception e ){
			System.out.println("eee"+ e);
		}
		
		
	}

	/**
	 * 
	 */
	
}