package Ehr.vlu.o.vluo020.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;


public class VLUO020DAO extends AbstractDAO {
    /**
     * VLUO020DAO ������
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public VLUO020DAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass�� ������ ȣ�� **/
			super(p_dsId, p_tr);
	}

    /**
     * (��ȸ) DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO020_SHR(CBox p_box ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO020_SHR");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("EVL_YYYY"),
                p_box.get("ENO_NO"),
		};

			
		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}

	
	
    /**
     * ������ ��ȸ DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO020_SHR_01(CBox p_box ) throws CException {

		/** �ܺ� XML���� ���κ������� ������ ��ȸ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO020_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("EVL_YYYY"),                      // �ش�⵵
				p_box.get("ENO_NO"),                       	// ���
				p_box.get("GOAL_SEQ"),                      // SEQ				
		};

		prop.add("SCORE",  prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);		
		
		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}


	
    /**
     * ��ǥ���� (�Է�) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO020_INS(CBox p_box, GauceValueObject vo ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (�Է�) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO020_INS");

		/** ���� ����  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {

                JSPUtil.rns(vo.get("EVL_YYYY")),				//�ش�⵵
                JSPUtil.rns(vo.get("ENO_NO")), 					//�����ڻ��
                JSPUtil.rns(vo.get("GOAL_SEQ")), 				//GOAL_SEQ                
                JSPUtil.rns(vo.get("GOAL_NO")),					//��ǥ����(�����ø��� ������ �ο�)
                JSPUtil.rns(vo.get("CATEGORY")),             	//ī�װ�
                JSPUtil.rns(vo.get("FORMULA")),             	//���θ�ǥ
                JSPUtil.rns(vo.get("GOALSET")),       			//��ǥ
                JSPUtil.rns(vo.get("WEIGHT")),       			//����         
                JSPUtil.rns(p_box.get("vusrid")),        		//�����ȣ
                JSPUtil.rns(p_box.get("vusrid"))         		//�����ȣ
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}

	
    /**
     * ��ǥ���� (�Է�) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO020_INS2(CBox p_box, GauceValueObject vo ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (�Է�) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO020_INS2");

		/** ���� ����  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {

                JSPUtil.rns(vo.get("EVL_YYYY")),				//�ش�⵵
                JSPUtil.rns(vo.get("ENO_NO")), 					//�����ڻ��
                JSPUtil.rns(vo.get("GOAL_SEQ")), 				//GOAL_SEQ                
                JSPUtil.rns(vo.get("GOAL_NO")),					//��ǥ����(�����ø��� ������ �ο�)
                JSPUtil.rns(vo.get("CATEGORY")),             	//ī�װ�
                JSPUtil.rns(vo.get("FORMULA")),             	//���θ�ǥ
                JSPUtil.rns(vo.get("GOALSET_HALF")),       		//��ǥ
                JSPUtil.rns(vo.get("GOALSET_10")),       			//��ǥ_10��                
                JSPUtil.rns(vo.get("GOALSET")),       			//��ǥ
                JSPUtil.rns(vo.get("WEIGHT")),       			//����
                JSPUtil.rns(vo.get("GRADE_S")),     	//S���
                JSPUtil.rns(vo.get("GRADE_A")),      	//A���
                JSPUtil.rns(vo.get("GRADE_B")),      	//B���
                JSPUtil.rns(vo.get("GRADE_C")),		//C���
                JSPUtil.rns(vo.get("GRADE_D")),       //D���
                JSPUtil.rns(vo.get("SELF_COMMENT")),       			//����
                JSPUtil.rns(vo.get("SELF_SCR")),       			//������            
                JSPUtil.rns(p_box.get("vusrid")),        		//�����ȣ
                JSPUtil.rns(p_box.get("vusrid"))         		//�����ȣ
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}	
	
    /**
     * ���� ���� ����Ʈ ���� DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO020_INS_01(CBox p_box, GauceValueObject vo ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (�Է�) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO020_INS_01");

		/** ���� ����  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid")),        		//�����ȣ
                JSPUtil.rns(vo.get("EVL_YYYY")),				//�ش�⵵
                JSPUtil.rns(vo.get("ENO_NO")) 					//�����ڻ��
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}

	
	
    /**
     * ��� DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO020_SAV_01(CBox p_box,  GauceValueObject vo) throws CException {

		/** �ܺ� XML���� ��ǥ���� (�Է�) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO020_UPT_01");

		/** ���� ����  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid")),         			//�����ȣ      
				JSPUtil.rns(vo.get("EVL_YYYY")),					//�ش�⵵
                JSPUtil.rns(vo.get("ENO_NO")), 					//�����ڻ��
                JSPUtil.rns(vo.get("GOAL_SEQ")),					//��ǥ����  
                JSPUtil.rns(vo.get("GOAL_NO")),					//��ǥ����                 
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}		
	
	
	
	
	
    /**
     * ��� DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO020_SAV_011(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ǥ���� (�Է�) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO020_UPT_011");

		/** ���� ����  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid")),         			//�����ȣ      
				JSPUtil.rns(p_box.get("EVL_YYYY")),				//�ش�⵵
                JSPUtil.rns(p_box.get("ENO_NO")), 				//�����ڻ��
                JSPUtil.rns(p_box.get("GOAL_SEQ")),				//��ǥ����  
                
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}			
	
	
	
	
	
    /**
     * ��ǥ���� (����) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO020_UPT(CBox p_box, GauceValueObject vo ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO020_UPT");

		/** ���� ���� �� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("CATEGORY")),		//����(0:��KPI����,1:��������)
                JSPUtil.rns(vo.get("KPI")),					//KPI
                JSPUtil.rns(vo.get("FORMULA")),		//�����
                JSPUtil.rns(vo.get("GOAL")),        		//��ǥ
                JSPUtil.rns(vo.get("GRADE_S")),     	//S���
                JSPUtil.rns(vo.get("GRADE_A")),      	//A���
                JSPUtil.rns(vo.get("GRADE_B")),      	//B���
                JSPUtil.rns(vo.get("GRADE_C")),		//C���
                JSPUtil.rns(vo.get("GRADE_D")),       //D���
                JSPUtil.rns(vo.get("WEIGHT")),  		//����
                JSPUtil.rns(vo.get("KPI_SEQ")),			//KPI����
                JSPUtil.rns(p_box.get("MOD_YN")),			//���� ��������
                JSPUtil.rns(p_box.get("SESSION_ENONO")),	//����������
                JSPUtil.rns(vo.get("EVL_YYYY")),		//�ش�⵵
                JSPUtil.rns(vo.get("EVL_FRQ")),			//������
                JSPUtil.rns(vo.get("ENO_NO")),     		//�����ڻ��
                JSPUtil.rns(vo.get("GOAL_NO")), 		//��ǥ����(�����ø��� ������ �ο�)
                JSPUtil.rns(vo.get("SEQ"))					//�ʱ� KPI����
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}



    /**
     * ��ǥ���� (����) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO020_DEL(CBox p_box, GauceValueObject vo) throws CException {

        //�����ͻ���
		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO020_DEL");

		/** ���� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVL_YYYY")),		//�ش�⵵
                JSPUtil.rns(vo.get("EVL_FRQ")),			//������
                JSPUtil.rns(vo.get("ENO_NO")),     		//�����ڻ��
                JSPUtil.rns(vo.get("GOAL_NO")), 		//��ǥ����(�����ø��� ������ �ο�)
                JSPUtil.rns(vo.get("SEQ"))					//�ʱ� KPI����
		};
		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}

	/**
     * ��ǥ���� (��ü����) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO020_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

        //�����ͻ���
		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO020_DEL_01");

		/** ���� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVL_YYYY")),		//�ش�⵵
                JSPUtil.rns(vo.get("ENO_NO")),     		//�����ڻ��
                JSPUtil.rns(vo.get("GOAL_SEQ")),     	//GOAL_SEQ                
		};
		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}

}
