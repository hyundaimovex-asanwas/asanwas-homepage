/*********************************************************************************
 *  �ϳ����� ������ ����
 * *******************************************************************************
 *
 * 1.Ŭ����   �� : BillrateDAO.java
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

public class MathUtil {
	private MathUtil() {
	}

	/*****************************************************************************
	 * ���üũ *
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