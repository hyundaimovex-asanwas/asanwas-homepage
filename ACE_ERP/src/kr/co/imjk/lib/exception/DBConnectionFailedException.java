/*
 * DB Pool로 부터 Connection 객체를 가져오지 못하였을때 만들어지는 예외 클래스
 *
 * @ author : 심재진 
 * @ E-mail : sim11@miraenet.com
 * @ date : 2001-07-19
 *
 */
 
package kr.co.imjk.lib.exception;

public class DBConnectionFailedException extends Exception {

	public DBConnectionFailedException() {

		super();
	}

	public DBConnectionFailedException(String msg) {

		super(msg);
	}
}
