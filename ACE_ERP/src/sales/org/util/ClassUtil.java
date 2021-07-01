/*********************************************************************************
 *  �ϳ����� ������ ����
 * *******************************************************************************
 *
 * 1.Ŭ����   �� : ClassUtil.java
 * 2.Ŭ���� ���� :
 * 3.���� ���̺� :
 * 4.���� Ŭ���� :
 * 5.���� ������ :
 * 6.��   ��  �� : ���¼�
 * 7.�� �� �� �� : 2004-03-30
 * 8.�� �� �� �� :
 * . <��¥>       ; <���� ����> (<�����ڸ�>)
 * . 2004-03-24      ;
 * @author ���¼�
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
	 * �޼ҵ��� ��� *
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
	 * �ʵ������ *
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
	 * DTO�� ��Ʈ������ ��ȯ ���� : ������ ���ڿ� �������� ���� ������ �� *
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
	 * ��Ʈ���� DTO�� ��´�. *
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
	 * DTO�� null���� ����ó���Ѵ�. *
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