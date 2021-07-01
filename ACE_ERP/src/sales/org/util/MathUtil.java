/*********************************************************************************
 *  하나은행 데이터 이전
 * *******************************************************************************
 *
 * 1.클래스   명 : BillrateDAO.java
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

public class MathUtil {
	private MathUtil() {
	}

	/*****************************************************************************
	 * 배수체크 *
	 ****************************************************************************/
	public static boolean isMultiple(int i1, int i2) {
		if (Math.round(Double.longBitsToDouble(i1) / Double.longBitsToDouble(i2)) == (Double
				.longBitsToDouble(i1) / Double.longBitsToDouble(i2))) {
			return true;
		} else {
			return false;
		}
	}

	public static boolean isMultiple(long i1, long i2) {
		if (Math.round(Double.longBitsToDouble(i1) / Double.longBitsToDouble(i2)) == (Double
				.longBitsToDouble(i1) / Double.longBitsToDouble(i2))) {
			return true;
		} else {
			return false;
		}
	}
}