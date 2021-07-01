package Ehr.yac.a.yaca030.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA030DAO extends AbstractDAO {

	/**
	 * YACA030DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA030DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �Ƿ��������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA030_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		//prop.add("COM_NO", ColumnProp.COLUMN_TYPE_STRING, 12, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("COM_NM", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("CARD_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 3, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("CASH_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 3, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �Ƿ��������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA030_SHR_14(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_SHR_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		prop.add("CASH_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 3, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * �Ƿ��������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA030_SHR_15(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_SHR_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		prop.add("CASH_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 3, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	
	
	/**
	 * ���� ����� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA030_SHR_FAM(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_SHR_FAM");

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
	 * ���� ����� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA030_SHR_FAM_14(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_SHR_FAM_14");

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
	 * ���� ����� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void YACA030_SHR_FAM_15(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_SHR_FAM_15");

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
	 * �Ƿ��������� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_INS(CBox p_box, String[][] dsArray, int i) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_INS");
		//System.out.print("p_box22222222222222222222 ================= "+p_box);
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				dsArray[i][0],//�ͼӳ൵
				dsArray[i][1],//�����ȣ
				dsArray[i][2],//ī��(���ݿ�����)
				dsArray[i][3],//����Ǽ�
				dsArray[i][4],//����
				dsArray[i][5],//����Ǽ�
				dsArray[i][6],//�������
				dsArray[i][7].replaceAll("-", ""),//����ڵ�Ϲ�ȣ
				dsArray[i][8],//��������
				dsArray[i][9],//����
				dsArray[i][10].replaceAll("-", ""),//�ֹι�ȣ
				dsArray[i][11],//����
				dsArray[i][12],//�Ƿ������ڵ�
				p_box.get("SESSION_ENONO"),				//�Է���
				p_box.get("SESSION_ENONO")				//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	
	/**
	 * �Ƿ��������� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_INS_14(CBox p_box, String[][] dsArray, int i) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_INS_14");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				dsArray[i][0],//�ͼӳ൵
				dsArray[i][1],//�����ȣ
				dsArray[i][2].replaceAll("-", ""),//����ڵ�Ϲ�ȣ
				dsArray[i][3],//��������
				dsArray[i][4],//����
				dsArray[i][5].replaceAll("-", ""),//�ֹι�ȣ
				dsArray[i][6],//����
				dsArray[i][7],//����
				dsArray[i][8],//����Ǽ�				
				dsArray[i][9],//�Ƿ������ڵ�
                p_box.get("vusrid"), //�Է���
                p_box.get("vusrid")  //������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}	
	
	/**
	 * �Ƿ��������� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_INS_15(CBox p_box, String[][] dsArray, int i) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_INS_15");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				dsArray[i][0],//�ͼӳ൵
				dsArray[i][1],//�����ȣ
				dsArray[i][2].replaceAll("-", ""),//����ڵ�Ϲ�ȣ
				dsArray[i][3],//��������
				dsArray[i][4],//����
				dsArray[i][5].replaceAll("-", ""),//�ֹι�ȣ
				dsArray[i][6],//����
				dsArray[i][7],//����
				dsArray[i][8],//����Ǽ�				
				dsArray[i][9],//�Ƿ������ڵ�
                p_box.get("vusrid"), //�Է���
                p_box.get("vusrid")  //������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}	
	
	/**
	 * �Ƿ��������� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//�ͼӳ൵
				vo.get("ENO_NO"),						//�����ȣ
				vo.get("COM_NO").replaceAll("-", ""),	//����ڵ�Ϲ�ȣ
				vo.get("CET_NO").replaceAll("-", ""),	//�ֹι�ȣ
				vo.get("MED_CD").replaceAll("-", ""),	//�����ڵ�			
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}


	
	/**
	 * �Ƿ��������� ��ü ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//�ͼӳ൵
				vo.get("ENO_NO"),						//�����ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	/**
	 * �Ƿ��������� ����(����û���� �����ϴ� �Ƿ���� �ڷ���)
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL_02(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//�ͼӳ൵
				vo.get("ENO_NO"),					//�����ȣ
				vo.get("MED_CD"),					//�Ƿ������ڵ�
				vo.get("CET_NO").replaceAll("-", ""),	//�ֹι�ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}
	
	/**
	 * �Ƿ��������� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL_14(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//�ͼӳ൵
				vo.get("ENO_NO"),						//�����ȣ
				vo.get("COM_NO").replaceAll("-", ""),	//����ڵ�Ϲ�ȣ
				vo.get("CET_NO").replaceAll("-", ""),	//�ֹι�ȣ
				vo.get("MED_CD").replaceAll("-", ""),	//�����ڵ�			
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}
	
	/**
	 * �Ƿ��������� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL_15(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//�ͼӳ൵
				vo.get("ENO_NO"),						//�����ȣ
				vo.get("COM_NO").replaceAll("-", ""),	//����ڵ�Ϲ�ȣ
				vo.get("CET_NO").replaceAll("-", ""),	//�ֹι�ȣ
				vo.get("MED_CD").replaceAll("-", ""),	//�����ڵ�			
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}
	
	/**
	 * �Ƿ��������� ��ü ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL2_14(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL2_14");		
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//�ͼӳ൵
				vo.get("ENO_NO"),						//�����ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}	
	
	/**
	 * �Ƿ��������� ��ü ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL2_15(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL2_15");		
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//�ͼӳ൵
				vo.get("ENO_NO"),						//�����ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}	
	
	/**
	 * �Ƿ��������� ����(����û���� �����ϴ� �Ƿ���� �ڷ���)
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL3_14(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL3_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//�ͼӳ൵
				vo.get("ENO_NO"),					//�����ȣ
				vo.get("MED_CD"),					//�Ƿ������ڵ�
				vo.get("CET_NO").replaceAll("-", ""),	//�ֹι�ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}	

	/**
	 * �Ƿ��������� ����(����û���� �����ϴ� �Ƿ���� �ڷ���)
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL3_15(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL3_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//�ͼӳ൵
				vo.get("ENO_NO"),					//�����ȣ
				vo.get("MED_CD"),					//�Ƿ������ڵ�
				vo.get("CET_NO").replaceAll("-", ""),	//�ֹι�ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}	


	
	/**
	 * �Ƿ��������� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_UPT_FAM(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_UPT_FAM");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO"),
		
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * �Ƿ��������� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_UPT_FAM_14(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_UPT_FAM_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO"),
		
		};
		
		System.out.println("YACA030_UPT_FAM_14::"+p_box.get("PIS_YY"));

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}	
	
	/**
	 * �Ƿ��������� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_UPT_FAM_15(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_UPT_FAM_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO"),
		
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}	
	
	
	/**
	 * �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_UPT_ACC(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_UPT_ACC");

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
	public void YACA030_UPT_ACC_14(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_UPT_ACC_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}		
	
	
	/**
	 * �Ƿ�� �����������̺� �ݿ�
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_UPT_ACC_15(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_UPT_ACC_15");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//�ͼӳ൵
				p_box.get("ENO_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}		
	
	
	
}
