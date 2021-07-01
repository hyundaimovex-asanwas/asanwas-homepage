/*********************************************************************************
 *  하나은행 데이터 이전
 * *******************************************************************************
 *
 * 1.클래스   명 : ClassUtil.java
 * 2.클래스 개요 :
 * 3.관련 테이블 :
 * 4.관련 클래스 :
 * 5.관련 페이지 :
 * 6.작   성  자 : 이태선
 * 7.작 성 일 자 : 2004-03-30
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
 * . 2004-03-24      ;
 * @author 이태선
 * @version 1.0 2004-03-30
 * *****************************************************************************
 */

package sales.org.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.security.AccessController;
import java.security.PrivilegedAction;
import java.util.Enumeration;
import java.util.Hashtable;

public class ClassUtil {

	private ClassUtil(){}

	/*****************************************************************************
	 * 메소드목록 찍기 *
	 ****************************************************************************/
	public static String listMethods(Object o) {
		StringBuffer ret = new StringBuffer();
		try {
			// Class c = Class.forName(strs[0]);
			Class c = o.getClass();
			Method m[] = c.getDeclaredMethods();
			for (int i = 0; i < m.length; i++) {
				ret.append(c.getName());
				ret.append(m[i].getName());
				ret.append(m[i].toString());
				ret.append(m[i].getReturnType().toString());
			}
		} catch (Throwable e) {
			System.out.println(e.getMessage());
		}
		return ret.toString();
	}

	/*****************************************************************************
	 * 필드목록찍기 *
	 ****************************************************************************/
	public static String listFields(Object o) {
		StringBuffer ret = new StringBuffer();
		try {
			// Class c = Class.forName(strs[0]);
			Class c = o.getClass();
			Field f[] = c.getDeclaredFields();
			for (int i = 0; i < f.length; i++) {
				ret.append(c.getName());
				ret.append(f[i].getName());
				ret.append(f[i].toString());
				ret.append(f[i].getType().toString());
			}
		} catch (Throwable e) {
			System.out.println(e.getMessage());
		}
		return ret.toString();
	}

	/*****************************************************************************
	 * DTO를 스트링으로 변환 저자 : 정문규 저자와 사전협의 없이 맘데루 씀 *
	 ****************************************************************************/
	public static String dtoToString(Object obj) {
		if (obj == null) {
			return "Object is null";
		}
		Class clz = obj.getClass();
		final Class fclz = clz;
		Hashtable hash = new Hashtable();
		StringBuffer dtoString = new StringBuffer();
		Method[] result;
		result = (Method[]) AccessController.doPrivileged(new PrivilegedAction() {
			public Object run() {
				return fclz.getDeclaredMethods();
			}
		});
		for (int i = 0; i < result.length; i++) {
			Method method = result[i];
			int mods = method.getModifiers();
			if (Modifier.isPublic(mods)) {
				String methodName = method.getName();
				String elementName = null;
				if (methodName.startsWith("get")) {
					elementName = methodName.substring(3);
				} else if (methodName.startsWith("is")) {
					elementName = methodName.substring(2);
				} else {
					continue;
				}
				try {
					dtoString.append(elementName + "=");
					Object value = method.invoke(obj, new Object[0]);
					dtoString.append(value);
					dtoString.append("|");
				} catch (Exception e) {
				}
			}
		}
		return dtoString.toString();
	}

	/*****************************************************************************
	 * 스트링을 DTO에 담는다. *
	 ****************************************************************************/
	public static Object StringTodto(Object obj, String str) {
		if (obj == null) {
			return "Object is null";
		}
		if (StringUtil.isNull(str)) {
			return "Parameter is null";
		}
		Class clz = obj.getClass();
		final Class fclz = clz;
		Hashtable hash = StringUtil.stringToHash(str, "|");
		Method[] result;
		result = (Method[]) AccessController.doPrivileged(new PrivilegedAction() {
			public Object run() {
				return fclz.getDeclaredMethods();
			}
		});
		for (int i = 0; i < result.length; i++) {
			Method method = result[i];
			int mods = method.getModifiers();
			if (Modifier.isPublic(mods)) {

				String methodName = method.getName();
				String elementName = null;
				if (methodName.startsWith("set")) {
					elementName = methodName.substring(3);
				} else {
					continue;
				}
				try {
					for (Enumeration e = hash.keys(); e.hasMoreElements();) {
						String tmpstr = (String) e.nextElement();
						if (elementName.equals(tmpstr)) {
							String[] param = new String[] { (String) hash.get(tmpstr) };
							Object value = method.invoke(obj, param);
						}
					}
				} catch (Exception e) {
				}

			}
		}
		return obj;
	}

	/*****************************************************************************
	 * DTO의 null값을 공백처리한다. *
	 ****************************************************************************/
	public static void dtonvl(Object obj, String changeVal) {
		Class clz = obj.getClass();
		final Class fclz = clz;
		Hashtable hash = new Hashtable();
		StringUtil.nvl(changeVal);

		Method[] result;
		result = (Method[]) AccessController.doPrivileged(new PrivilegedAction() {public Object run() {return fclz.getDeclaredMethods();}});

		for (int i = 0; i < result.length; i++) {
			Method method = result[i];
			int mods = method.getModifiers();
			if (Modifier.isPublic(mods)) {
				String methodName = method.getName();
				hash.put(methodName, method);
			}
		}

		for (int i = 0; i < result.length; i++) {
			Method method = result[i];
			int mods = method.getModifiers();
			if (Modifier.isPublic(mods)) {
				if (result[i].getName().startsWith("get")) {
					String methodName = method.getName();
					String properyName = methodName.substring(3);
					if (method.getReturnType().equals(java.lang.String.class)) {
						try {
							Object value = method.invoke(obj, new Object[0]);
							if (value == null) {
								try {
									Method setMethod = (Method) hash.get("set" + properyName);
									String val = changeVal;
									Object o[] = new Object[1];
									o[0] = (Object) val;
									try {
										setMethod.invoke(obj, o);
									} catch (NullPointerException e) {
									}
								} catch (SecurityException e1) {
									e1.printStackTrace();
								}
							}
						} catch (IllegalArgumentException e) {
						} catch (IllegalAccessException e) {
						} catch (InvocationTargetException e) {
						}
					}
				}
			}
		}
	}

	public static void dtonvl(Object obj) {
		dtonvl(obj, "");
	}
}