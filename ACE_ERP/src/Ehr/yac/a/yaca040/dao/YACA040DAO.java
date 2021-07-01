package Ehr.yac.a.yaca040.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA040DAO extends AbstractDAO {

	/**
	 * YACA040DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA040DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ��αݰ������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA040_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		//prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 9, ColumnProp.CONSTRAINT_TB_KEY);

		//prop.add("REL_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("COM_NO", ColumnProp.COLUMN_TYPE_STRING, 12, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("COM_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("FAM_NO", ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("SEQ_NO", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("TOT_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 3, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ��αݰ��� ����� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA040_SHR_05(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_SHR_05");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 9, ColumnProp.CONSTRAINT_TB_KEY);

		prop.add("FAM_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NO", ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_KEY);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	/**
	 * ��αݰ������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA040_SHR_14(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_SHR_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * ��αݰ������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA040_SHR_15(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_SHR_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ��αݰ��� ����� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA040_SHR2_14(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_SHR2_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 9, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NO", ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_KEY);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * ��αݰ��� ����� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA040_SHR2_15(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_SHR2_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 9, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NO", ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_KEY);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
	 * ��αݰ������� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_INS(CBox p_box, String[][] dsArray, int i) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
    
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO
				dsArray[i][2],//REL_CD
				dsArray[i][4],//REMARK
				dsArray[i][5].replaceAll("-", ""),//COM_NO
				dsArray[i][6],//COM_NM
				dsArray[i][7],//TOT_CNT
				dsArray[i][8],//SUM_AMT
				dsArray[i][10],//FAM_CD
				dsArray[i][11],//FAM_NM
				dsArray[i][12],//FAM_NO
				dsArray[i][13],//NTS_YN				
				p_box.get("vusrid"),					//�Է���
				p_box.get("vusrid")					//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	
	/**
	 * ��αݰ������� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_INS_14(CBox p_box, String[][] dsArray, int i) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_INS_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
    
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO
				dsArray[i][2],//REL_CD
				dsArray[i][3],//REMARK
				dsArray[i][4].replaceAll("-", ""),//COM_NO
				dsArray[i][5],//COM_NM
				dsArray[i][6],//TOT_CNT
				dsArray[i][7],//SUM_AMT
				dsArray[i][8],//FAM_CD
				dsArray[i][9],//FAM_NM
				dsArray[i][10],//FAM_NO
				dsArray[i][11],//NTS_YN				
				p_box.get("vusrid"),					//�Է���
				p_box.get("vusrid")					//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}	
	
	/**
	 * ��αݰ������� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_INS_15(CBox p_box, String[][] dsArray, int i) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_INS_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
    
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO
				dsArray[i][2],//REL_CD
				dsArray[i][3],//REMARK
				dsArray[i][4].replaceAll("-", ""),//COM_NO
				dsArray[i][5],//COM_NM
				dsArray[i][6],//TOT_CNT
				dsArray[i][7],//SUM_AMT
				dsArray[i][8],//FAM_CD
				dsArray[i][9],//FAM_NM
				dsArray[i][10],//FAM_NO
				dsArray[i][11],//NTS_YN				
				p_box.get("vusrid"),					//�Է���
				p_box.get("vusrid")					//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}	

	
	/**
	 * ��αݰ������� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//�ͼӳ൵
				vo.get("ENO_NO"),							//�����ȣ
				vo.get("REL_CD"),								//�������
				vo.get("REL_CD"),								//�������
				vo.get("COM_NO").replaceAll("-", ""),	//����ڵ�Ϲ�ȣ
				vo.get("REL_CD"),								//�������
				vo.get("FAM_NO"),								//�ֹε�Ϲ�ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	
	public void YACA040_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_DEL_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//�ͼӳ൵
				vo.get("ENO_NO"),							//�����ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}	
	
	
	/**
	 * ��αݰ������� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_DEL_14(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_DEL_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//�ͼӳ⵵
				vo.get("ENO_NO"),							//�����ȣ
				vo.get("REL_CD"),								//�������
				vo.get("REL_CD"),								//�������
				vo.get("COM_NO").replaceAll("-", ""),	//����ڵ�Ϲ�ȣ
				vo.get("REL_CD"),								//�������
				vo.get("FAM_NO"),								//�ֹε�Ϲ�ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}
	
	/**
	 * ��αݰ������� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_DEL_15(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_DEL_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//�ͼӳ⵵
				vo.get("ENO_NO"),							//�����ȣ
				vo.get("REL_CD"),								//�������
				vo.get("REL_CD"),								//�������
				vo.get("COM_NO").replaceAll("-", ""),	//����ڵ�Ϲ�ȣ
				vo.get("REL_CD"),								//�������
				vo.get("FAM_NO"),								//�ֹε�Ϲ�ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	
	public void YACA040_DEL_ALL_14(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_DEL_ALL_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//�ͼӳ⵵
				vo.get("ENO_NO"),							//�����ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}		
	
	public void YACA040_DEL_ALL_15(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_DEL_ALL_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//�ͼӳ⵵
				vo.get("ENO_NO"),							//�����ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}		
	
	
	
	/**
	 * ��α� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_FAM(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_FAM");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ��α� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_ACC(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_ACC");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	
	/**
	 * ��α� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_FAM_14(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_FAM_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	
	/**
	 * ��α� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_FAM_15(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_FAM_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	
	

	/**
	 * ��α� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_RET_14(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_ACC_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	
	/**
	 * ��α� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_RET_15(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_ACC_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	
	/**
	 * ��α� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_ACC_14(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_ACC_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ⵵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}	
	
	/**
	 * ��α� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_ACC_15(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_ACC_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ⵵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}	
	
	
}
