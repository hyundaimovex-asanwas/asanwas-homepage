package transfer;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class NumFormat {

	public static String NumFormat(String ev) {
		String flag = "N";
		int ival = 0;
		try{
			if (ev.equals("")) ev = "0.0";
			else if (ev.equals("null")) ev = "0.0";

			ival = (int) (Float.parseFloat(ev));

			flag = "Y";
		}catch(Exception e){
			flag = "N";
		}
		return flag;
	}
}