package Ehr.yac.a.yaca060.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA060DAO extends AbstractDAO {

	/**
	 * YACA060DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA060DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ��������������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA060_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		//prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 9, ColumnProp.CONSTRAINT_TB_KEY);

		//prop.add("PEN_TYPE_CD", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("PEN_TYPE_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("PEN_GUBUN_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("PEN_GUBUN_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("SEQ_NO", ColumnProp.COLUMN_TYPE_STRING, 1, ColumnProp.CONSTRAINT_TB_KEY);

		//prop.add("ABA_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("ABA_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("ACC_NO", ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("YEAR_SEQ", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 12, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("NTS_YN", ColumnProp.COLUMN_TYPE_STRING, 1, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ��������������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA060_SHR_14(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_SHR_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * ��������������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA060_SHR_15(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_SHR_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
	 * ��������������� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_INS(CBox p_box, String[][] dsArray, int i) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO				
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO	
				dsArray[i][2],//PEN_TYPE_CD
				dsArray[i][3],//PEN_TYPE_NM				
				dsArray[i][4],//PEN_GUBUN_CD
				dsArray[i][5],//PEN_GUBUN_NM
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO					
				dsArray[i][2],//PEN_TYPE_CD				
				dsArray[i][4],//PEN_GUBUN_CD				
				dsArray[i][7],//ABA_CD
				dsArray[i][8],//ABA_NM
				dsArray[i][9].replaceAll("-", ""),//ACC_NO					
				dsArray[i][10],//YEAR_SEQ
				dsArray[i][11],//AMOUNT
				dsArray[i][12],//NTS_YN				
				p_box.get("SESSION_ENONO"),					//�Է���
				p_box.get("SESSION_ENONO")					//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	
	/**
	 * ��������������� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_INS_14(CBox p_box, String[][] dsArray, int i) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_INS_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO				
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO	
				dsArray[i][2],//PEN_TYPE_CD
				dsArray[i][3],//PEN_TYPE_NM				
				dsArray[i][4],//PEN_GUBUN_CD
				dsArray[i][5],//PEN_GUBUN_NM
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO					
				dsArray[i][2],//PEN_TYPE_CD				
				dsArray[i][4],//PEN_GUBUN_CD				
				dsArray[i][7],//ABA_CD
				dsArray[i][8],//ABA_NM
				dsArray[i][9].replaceAll("-", ""),//ACC_NO					
				dsArray[i][10],//AMOUNT
				dsArray[i][11],//NTS_YN
                p_box.get("vusrid"), //�Է���
                p_box.get("vusrid")  //������
                
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}	
	
	
	/**
	 * ��������������� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_INS_15(CBox p_box, String[][] dsArray, int i) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_INS_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO				
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO	
				dsArray[i][2],//PEN_TYPE_CD
				dsArray[i][3],//PEN_TYPE_NM				
				dsArray[i][4],//PEN_GUBUN_CD
				dsArray[i][5],//PEN_GUBUN_NM
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO					
				dsArray[i][2],//PEN_TYPE_CD				
				dsArray[i][4],//PEN_GUBUN_CD				
				dsArray[i][7],//ABA_CD
				dsArray[i][8],//ABA_NM
				dsArray[i][9].replaceAll("-", ""),//ACC_NO					
				dsArray[i][10],//AMOUNT
				dsArray[i][11],//NTS_YN
				dsArray[i][12],//IN_GB
                p_box.get("vusrid"), //�Է���
                p_box.get("vusrid")  //������
                
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}	
	
	
	/**
	 * ��������������� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//�ͼӳ൵
				vo.get("ENO_NO"),								//�����ȣ
				vo.get("PEN_TYPE_CD"),							//������������
				vo.get("PEN_GUBUN_CD"),							//�������౸��
				vo.get("ABA_CD"),	
				vo.get("ACC_NO"),											
				vo.get("SEQ_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	public void YACA060_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_DEL_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//�ͼӳ⵵
				vo.get("ENO_NO"),								//�����ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}	
	
	
	/**
	 * ��������������� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_DEL_14(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_DEL_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),										//�ͼӳ⵵
				vo.get("ENO_NO"),									//�����ȣ
				vo.get("PEN_TYPE_CD"),							//������������
				vo.get("PEN_GUBUN_CD"),							//�������౸��
				vo.get("ABA_CD"),	
				vo.get("ACC_NO")	,
				vo.get("SEQ_NO")				
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}
	
	/**
	 * ��������������� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_DEL_15(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_DEL_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),										//�ͼӳ⵵
				vo.get("ENO_NO"),									//�����ȣ
				vo.get("PEN_TYPE_CD"),							//������������
				vo.get("PEN_GUBUN_CD"),							//�������౸��
				vo.get("ABA_CD"),	
				vo.get("ACC_NO")	,
				vo.get("SEQ_NO")				
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	public void YACA060_DEL2_14(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_DEL2_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//�ͼӳ⵵
				vo.get("ENO_NO"),								//�����ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}	
	
	public void YACA060_DEL2_15(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_DEL2_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//�ͼӳ⵵
				vo.get("ENO_NO"),								//�����ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}	
	
	
	/**
	 * ��������������� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_UPT_FAM(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_UPT_FAM");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	
	
	/**
	 * ��������������� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_UPT_FAM_14(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_UPT_FAM_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}	

	/**
	 * ��������������� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_UPT_ACC(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_UPT_ACC");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	
	/**
	 * ��������������� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_UPT_ACC_14(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_UPT_ACC_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}	
	
	/**
	 * ��������������� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_UPT_ACC_15(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_UPT_ACC_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}	

	
}
