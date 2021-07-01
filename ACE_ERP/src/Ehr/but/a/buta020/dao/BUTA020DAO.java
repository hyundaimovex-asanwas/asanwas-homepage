package Ehr.but.a.buta020.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class BUTA020DAO extends AbstractDAO {

	/**
	 * BUTA020DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public BUTA020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ǰ�ǹ�ȣ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA020_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA020_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				"C%"
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ����ǰ�Ǽ� �ۼ� ����  ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet BUTA020_SHR_03(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO"),
		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * ���� ����������  ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet BUTA020_SHR_04(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_04");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO"),
				"B",
				p_box.get("ORD_NO"),
				"B"				
		};

		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REMARK1", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * ������ ����  ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet BUTA020_SHR_25(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA025_PRT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO"),
		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
	}	
	
	
	public void BUTA020_SHR_PER(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_PER");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * ����ǰ�Ǽ� �ۼ� ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void BUTA020_INS_01(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_INS_01");


		String cnt = JSPUtil.rns(vo.get("COM_CNT"));
		if(cnt == ""){//����
			cnt = "0";
		}

		//System.out.println("==================="+vo);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
			JSPUtil.rns(vo.get("ORD_NO")),				//ǰ�ǹ�ȣ
			JSPUtil.rns(vo.get("ENO_NO")),				//ǰ���ڻ��
			JSPUtil.rns(vo.get("NAM_KOR")),			//����
			JSPUtil.rns(vo.get("DPT_CD")),				//�μ��ڵ�
			JSPUtil.rns(vo.get("JOB_CD")),				//�����ڵ�
			JSPUtil.rns(vo.get("BUT_FR_YMD").replaceAll("-", "")),		//���������
			JSPUtil.rns(vo.get("BUT_FR_GBN")),		//��������ϱ���(A:����,P:����)
			JSPUtil.rns(vo.get("BUT_TO_YMD").replaceAll("-", "")),		//����������
			JSPUtil.rns(vo.get("BUT_TO_GBN")),		//���������ϱ���(A:����,P:����)
			JSPUtil.rns(vo.get("OFFER_GBN")),			//������������ ����
			JSPUtil.rns(vo.get("START_GBN")),			//������������ ��߱���
			JSPUtil.rns(vo.get("SLEEP_DAY")),			//�����ϼ�
			JSPUtil.rns(vo.get("BUT_DAY")),			//�����ϼ�
			JSPUtil.rns(vo.get("BUT_CITY")),			//������
			JSPUtil.rns(vo.get("CITY_DPT1")),			//���屸��1�����
			JSPUtil.rns(vo.get("CITY_ARV1")),			//���屸��1������
			JSPUtil.rns(vo.get("CITY_GBN1")),			//���屸��1�������
			JSPUtil.rns(vo.get("CITY_DPT2")),			//���屸��2�����
			JSPUtil.rns(vo.get("CITY_ARV2")),			//���屸��2������
			JSPUtil.rns(vo.get("CITY_GBN2")),			//���屸��2�������
			JSPUtil.rns(vo.get("CITY_DPT3")),			//���屸��3�����
			JSPUtil.rns(vo.get("CITY_ARV3")),			//���屸��3������
			JSPUtil.rns(vo.get("CITY_GBN3")),			//���屸��3�������
			JSPUtil.rns(vo.get("CITY_DPT4")),			//���屸��4�����
			JSPUtil.rns(vo.get("CITY_ARV4")),			//���屸��4������
			JSPUtil.rns(vo.get("CITY_GBN4")),			//���屸��4�������
			JSPUtil.rns(vo.get("CITY_DPT5")),			//���屸��5�����
			JSPUtil.rns(vo.get("CITY_ARV5")),			//���屸��5������
			JSPUtil.rns(vo.get("CITY_GBN5")),			//���屸��5�������
			JSPUtil.rns(vo.get("CITY_DPT6")),			//���屸��6�����
			JSPUtil.rns(vo.get("CITY_ARV6")),			//���屸��6������
			JSPUtil.rns(vo.get("CITY_GBN6")),			//���屸��6�������
			JSPUtil.rns(vo.get("CITY_DPT7")),			//���屸��7�����
			JSPUtil.rns(vo.get("CITY_ARV7")),			//���屸��7������
			JSPUtil.rns(vo.get("CITY_GBN7")),			//���屸��7�������
			JSPUtil.rns(vo.get("CITY_DPT8")),			//���屸��8�����
			JSPUtil.rns(vo.get("CITY_ARV8")),			//���屸��8������
			JSPUtil.rns(vo.get("CITY_GBN8")),			//���屸��8�������
			JSPUtil.rns(vo.get("BUT_OBJ")),			//�������
			JSPUtil.rns(vo.get("BUT_ADDR")),			//��޿����ּ�
			JSPUtil.rns(vo.get("BUT_NAME")),			//��޿�������
			JSPUtil.rns(vo.get("BUT_PHONE")),		//��޿�����ȭ��ȣ
			JSPUtil.rns(vo.get("REMARK")),			//���
			JSPUtil.rns(vo.get("COM_YN")),			//�����ο���

			//JSPUtil.rns(vo.get("COM_CNT")),			//�����μ�
			cnt,
			JSPUtil.rns(vo.get("COM_CD1")),			//�����������ڵ�1
			JSPUtil.rns(vo.get("COM_NM1")),			//����������1
			JSPUtil.rns(vo.get("COM_NO1")),			//�����λ��1
			JSPUtil.rns(vo.get("COM_NAM1")),		//�������̸�1
			JSPUtil.rns(vo.get("COM_CD2")),			//�����������ڵ�2
			JSPUtil.rns(vo.get("COM_NM2")),			//����������2
			JSPUtil.rns(vo.get("COM_NO2")),			//�����λ��2
			JSPUtil.rns(vo.get("COM_NAM2")),		//�������̸�2
			JSPUtil.rns(vo.get("COM_CD3")),			//�����������ڵ�3
			JSPUtil.rns(vo.get("COM_NM3")),			//����������3
			JSPUtil.rns(vo.get("COM_NO3")),			//�����λ��3
			JSPUtil.rns(vo.get("COM_NAM3")),		//�������̸�3
			JSPUtil.rns(vo.get("COM_CD4")),			//�����������ڵ�4
			JSPUtil.rns(vo.get("COM_NM4")),			//����������4
			JSPUtil.rns(vo.get("COM_NO4")),			//�����λ��4
			JSPUtil.rns(vo.get("COM_NAM4")),		//�������̸�4
			JSPUtil.rns(vo.get("COM_CD5")),			//�����������ڵ�5
			JSPUtil.rns(vo.get("COM_NM5")),			//����������5
			JSPUtil.rns(vo.get("COM_NO5")),			//�����λ��5
			JSPUtil.rns(vo.get("COM_NAM5")),		//�������̸�5
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(vo.get("BUT_AFF")),		//����ȿ��
			JSPUtil.rns(vo.get("BUT_GBN")), 		//��������
			JSPUtil.rns(vo.get("PC_GBN")),		//��ǥ����
			JSPUtil.rns(vo.get("PC_CCTRCD")),	//��ǥ�ڵ�
			JSPUtil.rns(vo.get("PC_CCTRNM")) 	//��ǥ��
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * ����ǰ�� ������Ȳ�� �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void BUTA020_INS_02(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_INS_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
			JSPUtil.rns(p_box.get("ORD_NO")),				//ǰ�ǹ�ȣ
			JSPUtil.rns(p_box.get("ENO_NO")),				//ǰ���ڻ��
			JSPUtil.rns(p_box.get("NAM_KOR")),			//����
			JSPUtil.rns(p_box.get("DPT_CD")),				//�μ��ڵ�
			JSPUtil.rns(p_box.get("JOB_CD")),				//�����ڵ�
			"SV",														//�������
			"N",														//����ϷῩ��
			JSPUtil.rns(p_box.get("APP_CMT")),		//�������ǰ�
			"N",														//��ǥó������
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(p_box.get("vusrid"))
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * ���� ������������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void BUTA020_INS_03(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_INS_03");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUN_YMD")),			//������
				"B",
				JSPUtil.rns(vo.get("DPT_CD")),			//�μ�
				JSPUtil.rns(vo.get("SEQ_NO")),			//�Ϸù�ȣ
				JSPUtil.rns(vo.get("ENO_NO")),			//�����ڻ��
				JSPUtil.rns(vo.get("JOB_CD")),			//�����ڵ�
				JSPUtil.rns(p_box.get("vusrid")),			//����ڻ��
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("ORD_NO")),		//�����ȣ
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * ����ǰ�� ������Ȳ(���, ����, ����) ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_01(CBox p_box, GauceValueObject vo, String APP_YN) throws CException {


		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_01");

		/** ���¿� ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();

		if(vo.get("APP_STATUS").equals("SV")){//����
				sb.append("ORD_YMD = TO_CHAR(SYSDATE,'YYYYMMDD'),\n");
				sb.append("                   ORD_TIME = TO_CHAR(SYSDATE,'HH24MISS'),\n");
				sb.append("                   APP_CMT = '����',\n");//���

		}else if(APP_YN.equals("Y")){ //����Ϸ�
			sb.append("                   APP_COMP  = 'Y',\n");
			sb.append("                   TRANS_GBN = 'R',\n");//��ǥó������
			sb.append("                   APP_CMT = '����Ϸ�',\n");//����Ϸ�
		}else if(APP_YN.equals("N")){ // �ΰ�Ϸ�
			sb.append("                   APP_COMP  = 'N',\n");
			sb.append("                   TRANS_GBN = 'N',\n");//��ǥó���Ұ�
			sb.append("                   APP_CMT = '�ΰ�',\n");//�ΰ�ó��
		}else if(APP_YN.equals("E")){ // �ݼ�
			sb.append("                   APP_COMP  = 'E',\n");
			sb.append("                   TRANS_GBN = 'N',\n");//��ǥó���Ұ�
			sb.append("                   APP_CMT = '�ݼ�',\n");//�ݼ�ó��
		}

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),	//������
				JSPUtil.rns(vo.get("ORD_NO")),						//ǰ�ǹ�ȣ
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ���� ����������(���翩��) ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_02(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("APP_YN")),							//���翩��
				JSPUtil.rns(vo.get("APP_CMT")),						//REMARK
				JSPUtil.rns(p_box.get("vusrid")), 	//������
				JSPUtil.rns(vo.get("ORD_NO")),						    //ǰ�ǹ�ȣ
				JSPUtil.rns(p_box.get("vusrid"))	   //���
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	public void BUTA020_UPT_APP(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_APP");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),	   //���
				p_box.get("ORD_NO")  					    //ǰ�ǹ�ȣ

		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	public void BUTA020_UPT_STA(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_STA");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),	   //���
				p_box.get("ORD_NO")  					    //ǰ�ǹ�ȣ

		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	/**
	 * ����ڿ� ���翩�� 'N' ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_06(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_06");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				"N",										//���翩��
				JSPUtil.rns(p_box.get("vusrid")),	//������
				JSPUtil.rns(vo.get("ORD_NO")),						//ǰ�ǹ�ȣ
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}


	/**
	 * ����ǰ�Ǽ� ���� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_03(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_03");


		String cnt = JSPUtil.rns(vo.get("COM_CNT"));
		if(cnt == ""){//����
			cnt = "0";
		}
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("BUT_FR_YMD").replaceAll("-", "")),		//���������
				JSPUtil.rns(vo.get("BUT_FR_GBN")),		//��������ϱ���(A:����,P:����)
				JSPUtil.rns(vo.get("BUT_TO_YMD").replaceAll("-", "")),		//����������
				JSPUtil.rns(vo.get("BUT_TO_GBN")),		//���������ϱ���(A:����,P:����)
				JSPUtil.rns(vo.get("OFFER_GBN")),			//������������ ����
				JSPUtil.rns(vo.get("START_GBN")),			//������������ ��߱���
				JSPUtil.rns(vo.get("SLEEP_DAY")),			//�����ϼ�
				JSPUtil.rns(vo.get("BUT_DAY")),			//�����ϼ�
				JSPUtil.rns(vo.get("BUT_CITY")),			//������
				JSPUtil.rns(vo.get("CITY_DPT1")),			//���屸��1�����
				JSPUtil.rns(vo.get("CITY_ARV1")),			//���屸��1������
				JSPUtil.rns(vo.get("CITY_GBN1")),			//���屸��1�������
				JSPUtil.rns(vo.get("CITY_DPT2")),			//���屸��2�����
				JSPUtil.rns(vo.get("CITY_ARV2")),			//���屸��2������
				JSPUtil.rns(vo.get("CITY_GBN2")),			//���屸��2�������
				JSPUtil.rns(vo.get("CITY_DPT3")),			//���屸��3�����
				JSPUtil.rns(vo.get("CITY_ARV3")),			//���屸��3������
				JSPUtil.rns(vo.get("CITY_GBN3")),			//���屸��3�������
				JSPUtil.rns(vo.get("CITY_DPT4")),			//���屸��4�����
				JSPUtil.rns(vo.get("CITY_ARV4")),			//���屸��4������
				JSPUtil.rns(vo.get("CITY_GBN4")),			//���屸��4�������
				JSPUtil.rns(vo.get("CITY_DPT5")),			//���屸��5�����
				JSPUtil.rns(vo.get("CITY_ARV5")),			//���屸��5������
				JSPUtil.rns(vo.get("CITY_GBN5")),			//���屸��5�������
				JSPUtil.rns(vo.get("CITY_DPT6")),			//���屸��6�����
				JSPUtil.rns(vo.get("CITY_ARV6")),			//���屸��6������
				JSPUtil.rns(vo.get("CITY_GBN6")),			//���屸��6�������
				JSPUtil.rns(vo.get("CITY_DPT7")),			//���屸��7�����
				JSPUtil.rns(vo.get("CITY_ARV7")),			//���屸��7������
				JSPUtil.rns(vo.get("CITY_GBN7")),			//���屸��7�������
				JSPUtil.rns(vo.get("CITY_DPT8")),			//���屸��8�����
				JSPUtil.rns(vo.get("CITY_ARV8")),			//���屸��8������
				JSPUtil.rns(vo.get("CITY_GBN8")),			//���屸��8�������
				JSPUtil.rns(vo.get("BUT_OBJ")),			//�������
				JSPUtil.rns(vo.get("BUT_ADDR")),			//��޿����ּ�
				JSPUtil.rns(vo.get("BUT_NAME")),			//��޿�������
				JSPUtil.rns(vo.get("BUT_PHONE")),		//��޿�����ȭ��ȣ
				JSPUtil.rns(vo.get("REMARK")),				//���
				JSPUtil.rns(vo.get("COM_YN")),				//�����ο���

				cnt,
				//JSPUtil.rns(vo.get("COM_CNT")),			//�����μ�


				JSPUtil.rns(vo.get("COM_CD1")),			//�����������ڵ�1
				JSPUtil.rns(vo.get("COM_NM1")),			//����������1
				JSPUtil.rns(vo.get("COM_NO1")),			//�����λ��1
				JSPUtil.rns(vo.get("COM_NAM1")),			//�������̸�1
				JSPUtil.rns(vo.get("COM_CD2")),			//�����������ڵ�2
				JSPUtil.rns(vo.get("COM_NM2")),			//����������2
				JSPUtil.rns(vo.get("COM_NO2")),			//�����λ��2
				JSPUtil.rns(vo.get("COM_NAM2")),			//�������̸�2
				JSPUtil.rns(vo.get("COM_CD3")),			//�����������ڵ�3
				JSPUtil.rns(vo.get("COM_NM3")),			//����������3
				JSPUtil.rns(vo.get("COM_NO3")),			//�����λ��3
				JSPUtil.rns(vo.get("COM_NAM3")),			//�������̸�3
				JSPUtil.rns(vo.get("COM_CD4")),			//�����������ڵ�4
				JSPUtil.rns(vo.get("COM_NM4")),			//����������4
				JSPUtil.rns(vo.get("COM_NO4")),			//�����λ��4
				JSPUtil.rns(vo.get("COM_NAM4")),			//�������̸�4
				JSPUtil.rns(vo.get("COM_CD5")),			//�����������ڵ�5
				JSPUtil.rns(vo.get("COM_NM5")),			//����������5
				JSPUtil.rns(vo.get("COM_NO5")),			//�����λ��5
				JSPUtil.rns(vo.get("COM_NAM5")),			//�������̸�5
				p_box.get("vusrid"),
				JSPUtil.rns(vo.get("BUT_AFF")),				//����ȿ��
				JSPUtil.rns(vo.get("BUT_GBN")),				//��������
				JSPUtil.rns(vo.get("PC_GBN")),				//��ǥ����
				JSPUtil.rns(vo.get("PC_CCTRCD")),				//��ǥ�ڵ�
				JSPUtil.rns(vo.get("PC_CCTRNM")),				//��ǥ��
				JSPUtil.rns(vo.get("ORD_NO")),				//ǰ�ǹ�ȣ
				JSPUtil.rns(vo.get("ENO_NO"))				//���
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ���� ���������� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_04(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_04");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("AUTHO_CD")),					//�������۾������ڵ�
				JSPUtil.rns(p_box.get("vusrid")),	//������
				JSPUtil.rns(vo.get("ORD_NO")),						//ǰ�ǹ�ȣ
				JSPUtil.rns(vo.get("ENO_NO"))						//���
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}


	/**
	 * ���� ��¥���� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_SAV_DATE(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_DATE");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("BUT_FR_YMD").replaceAll("-", "")),		//���������
				JSPUtil.rns(vo.get("BUT_FR_GBN")),							//��������ϱ���(A:����,P:����)
				JSPUtil.rns(vo.get("BUT_TO_YMD").replaceAll("-", "")),		//����������
				JSPUtil.rns(vo.get("BUT_TO_GBN")),							//���������ϱ���(A:����,P:����)
				JSPUtil.rns(vo.get("SLEEP_DAY")),							//�����ϼ�
				JSPUtil.rns(vo.get("BUT_DAY")),								//�����ϼ�
				JSPUtil.rns(vo.get("ORD_NO"))								//ǰ�ǹ�ȣ

		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ���� ��¥���� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_DILIGENCE(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_DATE");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("BUT_FR_YMD").replaceAll("-", "")),		//���������
				JSPUtil.rns(vo.get("BUT_FR_GBN")),							//��������ϱ���(A:����,P:����)
				JSPUtil.rns(vo.get("BUT_TO_YMD").replaceAll("-", "")),		//����������
				JSPUtil.rns(vo.get("BUT_TO_GBN")),							//���������ϱ���(A:����,P:����)
				JSPUtil.rns(vo.get("SLEEP_DAY")),							//�����ϼ�
				JSPUtil.rns(vo.get("BUT_DAY")),								//�����ϼ�
				JSPUtil.rns(vo.get("ORD_NO"))								//ǰ�ǹ�ȣ

		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}	
	
	/**
	 * ����ǰ�� ������Ȳ(�ΰ�, �ݼ�) ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_05(CBox p_box, GauceValueObject vo) throws CException {

		int sel = Integer.parseInt(vo.get("APP_STATUS").substring(1, 2))+1;

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_01");

		/** ���¿� ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();

		sb.append("APP_STATUS = 'A"+sel+"',\n");
		sb.append("                   OUR_YMD"+sel+" = TO_CHAR(SYSDATE,'YYYYMMDD'),\n");
		sb.append("                   OUR_TIM"+sel+" = TO_CHAR(SYSDATE,'HH24MISS'),\n");

		if(vo.get("KIND").equals("�ΰ�")){
			sb.append("                   OUR_TAG"+sel+" = 'D',\n");
		}else if(vo.get("KIND").equals("�ݼ�")){
			sb.append("                   OUR_TAG"+sel+" = 'E',\n");
		}

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("APP_CMT")),					//�������ǰ�
				JSPUtil.rns(p_box.get("vusrid")),	//������
				JSPUtil.rns(vo.get("ORD_NO")),						//ǰ�ǹ�ȣ
				JSPUtil.rns(vo.get("ENO_NO"))						//���
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}


	/**
     * ������������� ���� DAO �޼���
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA020_DEL_01(CBox p_box ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTC020_DEL_01");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("ORD_NO")),
				"B"
		};


		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}

	/**
     * ����ǰ�Ǽ�������Ȳ ���� DAO �޼���
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA020_DEL_02(CBox p_box ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA010_DEL_02");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("ORD_NO")),
				JSPUtil.rns(p_box.get("ENO_NO"))
		};


		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}



	/**
	 * ���� ��������  ��ȸ(T_DI_DILIGENCE�� Update �ϱ� ���� �ڷ�)
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet BUTA020_SHR_05(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_05");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ORD_NO")),						//ǰ�ǹ�ȣ
				JSPUtil.rns(vo.get("ENO_NO"))						//���
		};


		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
	}
	/**
	 * ���� ��������  ��ȸ(T_DI_DILIGENCE�� Update �ϱ� ���� �ڷ�)
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet BUTA020_SHR_06(String NEXT_ENO, String Next_msg,CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_06");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				Next_msg,
				NEXT_ENO						//���
		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
	}
	public GauceDataSet BUTA020_SHR_07(String NEXT_ENO, String Next_msg,CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_07");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				Next_msg,
				NEXT_ENO						//���
		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
	}
	/**
	 * T_DI_DILIGENCE �� ���µ����͸� �ݿ�
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_DIL_INS_01(String YYYY, String ENO_NO,  String DPT_CD, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_DIL_IND_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				YYYY,
				ENO_NO,
				DPT_CD,
				YYYY,
				p_box.get("vusrid"),
				p_box.get("vusrid"),
				YYYY,
				ENO_NO
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);

	}


	/**
	 * ���ϱ������������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet BUTA020_DIL_SHR_01(String STR_YYYYMM, String END_YYYYMM, String ENO_NO, String STR_YYYYMMDD, String END_YYYYMMDD, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_DIL_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				STR_YYYYMM,
				END_YYYYMM,
				ENO_NO,
				STR_YYYYMMDD,
				END_YYYYMMDD
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;

	}
	/**
	 * T_DI_DILIGENCE �� �ݿ�(����)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_DIL_UPT_01(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");
		String COLNAME = "AT"+Integer.parseInt(PIS_YYMMDD.substring(6,8))+"_CD";
		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +"= '"+GUN_CD+"',");

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				ENO_NO,
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	
	/**
	 * T_DI_DILIGENCE �� �ݿ�(����)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_DIL_UPT_02(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_02");
		
		String COLNAME = "AT"+Integer.parseInt(PIS_YYMMDD.substring(6,8))+"_CD";
		
		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +"= '"+GUN_CD+"',");

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				ENO_NO,
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}	
	
	
	
	/**
	 * �����Ѱ踦 �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void BUTA020_DIL_UPT_03(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");
		String COLNAME = "";
		if("".equals(JSPUtil.rns(GUN_CD))){
			return;
		}
		if(GUN_CD.equals("A")) COLNAME="ATT_A";
		else if(GUN_CD.equals("B")) COLNAME="ATT_B";
		else if(GUN_CD.equals("C")) COLNAME="ATT_C";
		else if(GUN_CD.equals("D")) COLNAME="ATT_D";
		else if(GUN_CD.equals("E")) COLNAME="ATT_E";
		else if(GUN_CD.equals("F")) COLNAME="ATT_F";
		else if(GUN_CD.equals("G")) COLNAME="ATT_G";
		else if(GUN_CD.equals("H")) COLNAME="ATT_H";
		else if(GUN_CD.equals("I")) COLNAME="ATT_I";
		else if(GUN_CD.equals("J")) COLNAME="ATT_J";
		else if(GUN_CD.equals("K")) COLNAME="ATT_K";
		else if(GUN_CD.equals("L")) COLNAME="ATT_L";
		else if(GUN_CD.equals("M")) COLNAME="ATT_M";
		else if(GUN_CD.equals("N")) COLNAME="ATT_N";
		else if(GUN_CD.equals("O")) COLNAME="ATT_O";
		else if(GUN_CD.equals("P")) COLNAME="ATT_P";
		else if(GUN_CD.equals("Q")) COLNAME="ATT_Q";
		else if(GUN_CD.equals("R")) COLNAME="ATT_R";
		else if(GUN_CD.equals("S")) COLNAME="ATT_S";
		else if(GUN_CD.equals("U")) COLNAME="ATT_U";
		else if(GUN_CD.equals("V")) COLNAME="ATT_V";
		else if(GUN_CD.equals("X")) COLNAME="ATT_X";
		else if(GUN_CD.equals("Z")) COLNAME="ATT_Z";
		else if(GUN_CD.equals("W")) COLNAME="ATW_CNT";
		else if(GUN_CD.equals("Y")) COLNAME="HOL_CNT";
		else if(GUN_CD.equals("T")) COLNAME="HOW_CNT";

		if("".equals(COLNAME))
			return;

		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +"= DECODE("+COLNAME+", null, 0, "+COLNAME+"+1),");

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				ENO_NO,
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	/**
	 * ���� ��Ϲ�ȣ�� �����Ѱ�������(����)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public GauceDataSet BUTA020_CNT(GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_CNT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ORD_NO")),				//ǰ�ǹ�ȣ
				"B",
				JSPUtil.rns(vo.get("ORD_NO")),				//ǰ�ǹ�ȣ
				"B",
				JSPUtil.rns(vo.get("ORD_NO")),				//ǰ�ǹ�ȣ
				"B",
				JSPUtil.rns(vo.get("ORD_NO")),				//ǰ�ǹ�ȣ
				"B",
				JSPUtil.rns(vo.get("ORD_NO")),				//ǰ�ǹ�ȣ
				"B"
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		return selectProcess(sql, bind);
	}
}

