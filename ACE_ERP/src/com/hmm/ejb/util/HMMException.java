package com.hmm.ejb.util;

import javax.ejb.EJBException;

/**
 * @author 최상수
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
public class HMMException extends EJBException
{
	/**
	 * @param e
	 */
	public HMMException(Exception e) 
	{	
		this.exception = e;
	}

	public static final int EJB = 0;
	public static final int WEB = 1;
	public static final int BATCH = 2;
	private int exceptionType;             //   static final 코드 참
	private String errorCode = null;
	private String className = null;
	private String methodName = null;
	private Exception exception = null;

	public HMMException() 
	{
		super();
	}

	public HMMException(String errorCode) 
	{
		super(errorCode);
	}

	public HMMException(String errorCode,int exceptionType, String className,String methodName, Exception exception)
	{
		this.errorCode = errorCode;
		this.exceptionType = exceptionType;
		this.className = className;
		this.methodName = methodName;
		this.exception = exception;
	}

	public int getExceptionType()
	{
		return exceptionType;
	}

	public void setExceptionType(int exceptionType)
	{
		this.exceptionType = exceptionType;
	}

	public String getErrorCode()
	{
		return errorCode;
	}

	public void setErrorCode(String errorCode)
	{
		this.errorCode = errorCode;
	}

	public String getClassName()
	{
		return className;
	}

	public void setClassName(String className)
	{
		this.className = className;
	}

	public String getMethodName()
	{
		return methodName;
	}

	public void setMethodName(String methodName)
	{
		this.methodName = methodName;
	}

	public Exception getException()
	{
		return exception;
	}

	public void setException(Exception exception)
	{
		this.exception = exception;
	}
}
