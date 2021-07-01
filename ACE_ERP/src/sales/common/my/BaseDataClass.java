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

	private HashMap variables;	// �����͸� ������ HashMap

	// ������. ���� �ʱ�ȭ�Ѵ�.
	public BaseDataClass() {
		this.variables = new HashMap(20);
	}
	public BaseDataClass(ServletRequest req) {
		this.variables = new HashMap(20);
		setValues(req);
	}
	
	/***************************** Get Methods **********************************/

	// DataClass�� ���� element�� ������ ���Ѵ�.
	public int getSize() {
		if(variables != null) {
			return variables.size();
		} else {
			return 0;
		}
	}

	// ������ �ش��ϴ� Object�� �����´�.
	public Object getObject(String name) {
		return variables.get(name);
	}

	// ������ �ش��ϴ� String ���� �����´�.
	public String get(String name) {
		
		return getString(name);
	}
	public String getString(String name) {
		String val = null;
		val = nullCheck((String)variables.get(name));
		return val;
	}

	// ������ �ش��ϴ� int ���� �����´�.
	public int getInt(String name) {
		String val = getString(name);
		if("".equals(val)) val = "0";
		return Integer.parseInt(val);
	}

	// ������ �ش��ϴ� double ���� �����´�.
	public double getDouble(String name) {
		String val = getString(name);
		if("".equals(val)) val = "0";
		return Double.parseDouble(val);
	}

	// ������ �ش��ϴ� String �迭�� �����´�.
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

	// ������ �ش��ϴ� Object�� �����Ѵ�.
	public void set(String name, Object obj) {
		StringUtil.printMsg("["+name+"] [" + obj.toString() + "]", this);
		setObject(name, obj);
	}
	public void setObject(String name, Object obj) {
		
		StringUtil.printMsg("["+name+"] [" + obj.toString() + "]", this);
		variables.put(name, obj);
	}

	// ������ �ش��ϴ� ���� String���� �����Ѵ�.
	public void set(String name, String val) {
		
		setString(name, val);
	}
	public void setString(String name, String val) {
		StringUtil.printMsg("["+name+"] [" + val + "]", this);
		variables.put(name, nullCheck(val));
	}

	// ResultSet�� ������ HashMap�� �ִ´�.
	public void setValues(ResultSet rs) {
		try {
	        ResultSetMetaData rsmeta = rs.getMetaData();
	        int col_cnt = rsmeta.getColumnCount();

			//String type = null;
			String name = null;
			String val = null;

	        for(int i=0; i<col_cnt; i++) {

				// Table�� �÷��� �ҹ��ڷ� �����Ͽ� key�� ����Ѵ�.
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

	// ������ ������ "[������] : ������" String�� �����. Debug�� ���.
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

	/***************************** ��Ÿ Methods **********************************/

	// null ���� ""���� ó���Ѵ�.
	public String nullCheck(String str) {
		return  HDUtil.nullCheckStr(str);
	}
}
