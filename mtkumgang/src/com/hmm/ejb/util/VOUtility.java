/**
 * 작성일 : 2005-01-26
 * 작성자 : csangsu
 * Copy Write : Hyundai Merchant Marine Co. LTD.
 */
package com.hmm.ejb.util;

import com.hmm.ejb.common.HMMCommonVO;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

/**
 * HMM EJB Common.VOUtility.java.java
 */
public class VOUtility
{
	private static VOUtility loader;

	public static VOUtility getInstance() throws Exception {
		if (loader == null) {
			synchronized (VOUtility.class) {
				if (loader == null) {
					loader = new VOUtility();
				}
			}
		}
		return loader;
	}
	private VOUtility()
	{
	}

	public void voToString(Object obj, int inOut)
	{
		StringBuffer result = new StringBuffer();
		result.append("\n==============================[Start Debug]===============================");
        if(inOut == HMMCommonVO.EJB_IN)
        {
            result.append("\nI/O : Input");
        }else
        {
            result.append("\nI/O : Output");
        }
		try
		{
			Class cls = obj.getClass();
			result.append("\nClass Name : " + cls.getName());

			Field fieldlist[] = cls.getDeclaredFields();
			String getterMethod = "";
			Field f ;
			for(int i =0 , j = fieldlist.length ; i < j ; i++)
			{
				f=fieldlist[i];
				getterMethod = "get" + f.getName().substring(0,1).toUpperCase() + f.getName().substring(1);

				Method m = cls.getDeclaredMethod(getterMethod,null);
				Object value = m.invoke(obj,null);

				if(value!= null)
				{
					result.append("\nMethod Name & Value : ["  + f.getName() + ","  + value.toString() + "]");
				}
			}
			result.append("\n==============================[End   Debug]===============================");
		}
		catch (Throwable e) {
		   System.err.println(e);
		}
		System.out.println(result.toString());
	}
}

