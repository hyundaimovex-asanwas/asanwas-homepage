package sales.common.my;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.ServletRequest;

import sales.common.HDUtil;
import sales.common.StringUtil;


public class BaseDataClass implements Serializable {

	private HashMap variables;	// 데이터를 가지는 HashMap

	// 생성자. 값을 초기화한다.
	public BaseDataClass() {
		this.variables = new HashMap(20);
	}
	public BaseDataClass(ServletRequest req) {
		this.variables = new HashMap(20);
		setValues(req);
	}
	
	/***************************** Get Methods **********************************/

	// DataClass가 가진 element의 개수를 구한다.
	public int getSize() {
		if(variables != null) {
			return variables.size();
		} else {
			return 0;
		}
	}

	// 변수명에 해당하는 Object를 가져온다.
	public Object getObject(String name) {
		return variables.get(name);
	}

	// 변수명에 해당하는 String 값을 가져온다.
	public String get(String name) {
		
		return getString(name);
	}
	public String getString(String name) {
		String val = null;
		val = nullCheck((String)variables.get(name));
		return val;
	}

	// 변수명에 해당하는 int 값을 가져온다.
	public int getInt(String name) {
		String val = getString(name);
		if("".equals(val)) val = "0";
		return Integer.parseInt(val);
	}

	// 변수명에 해당하는 double 값을 가져온다.
	public double getDouble(String name) {
		String val = getString(name);
		if("".equals(val)) val = "0";
		return Double.parseDouble(val);
	}

	// 변수명에 해당하는 String 배열을 가져온다.
	public String[] getArrayString(String name) {
		String[] rtnArr = null;
		
		Object obj = getObject(name);

		if(obj != null) {
			if(obj.getClass().isArray()) {
				rtnArr = ((String []) obj);
			} else {
				rtnArr = new String[1];
				rtnArr[0] = (String)obj;
			}
			
		}
		return rtnArr;
	}

	/***************************** Set Methods **********************************/

	// 변수명에 해당하는 Object를 셋팅한다.
	public void set(String name, Object obj) {
		StringUtil.printMsg("["+name+"] [" + obj.toString() + "]", this);
		setObject(name, obj);
	}
	public void setObject(String name, Object obj) {
		
		StringUtil.printMsg("["+name+"] [" + obj.toString() + "]", this);
		variables.put(name, obj);
	}

	// 변수명에 해당하는 값을 String으로 셋팅한다.
	public void set(String name, String val) {
		
		setString(name, val);
	}
	public void setString(String name, String val) {
		StringUtil.printMsg("["+name+"] [" + val + "]", this);
		variables.put(name, nullCheck(val));
	}

	// ResultSet의 값들을 HashMap에 넣는다.
	public void setValues(ResultSet rs) {
		try {
	        ResultSetMetaData rsmeta = rs.getMetaData();
	        int col_cnt = rsmeta.getColumnCount();

			//String type = null;
			String name = null;
			String val = null;

	        for(int i=0; i<col_cnt; i++) {

				// Table의 컬럼을 소문자로 변경하여 key로 사용한다.
				name = rsmeta.getColumnName(i+1).toLowerCase();
				val = rs.getString(name);
				
				variables.put(name, nullCheck(val));
				
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public void setValues(ServletRequest req) {
		String name ;
		Object value ;
		try {
			for (Enumeration e = req.getParameterNames() ; e.hasMoreElements() ;) {
				name = (String)e.nextElement() ;
				value= (Object)req.getParameterValues( name );
				value= chkData( value );
				
				StringUtil.printMsg("SET Name" , name, this);
				StringUtil.printMsg("SET Value" , value+"", this);
				if(value.getClass().isArray()) {
					for(int i =0 ; i < ((String []) value).length ; i++) {
						((String[]) value)[i] = (String)((String[]) value)[i].trim();
					}
					variables.put( name, (Object[])value) ;
				} else {
					value = (Object) ((String)value).trim() ;
					variables.put( name, (Object)value) ;
				}
			}
		} catch(Exception e) {
			variables = new HashMap(20);
		}
	}

	public Object chkData(Object org) {
		if(org == null) return null ;
		if( org.getClass().isArray() &&	((Object[]) org).length <= 1) {
			return ((Object[]) org)[0] ;
		} else {
			return org ;
		}
	}

	// 변수와 값으로 "[변수명] : 변수값" String을 만든다. Debug시 사용.
	public String toString() {

        StringBuffer buff = new StringBuffer();
		String name = null;
		Object val = null;

		Iterator it = variables.keySet().iterator();
		ArrayList arr = new ArrayList();
		while(it.hasNext()) {
			arr.add(it.next());
		}
		Collections.sort(arr);

		int size = arr.size();
		for(int i=0; i<size; i++) {
			name = (String)arr.get(i);
			
			val = variables.get(name);
			
			
			buff.append("\n[" + name + "] [" + val.toString() + "]");
		}

		return buff.toString();
	}

	/***************************** 기타 Methods **********************************/

	// null 값을 ""으로 처리한다.
	public String nullCheck(String str) {
		return  HDUtil.nullCheckStr(str);
	}
}
