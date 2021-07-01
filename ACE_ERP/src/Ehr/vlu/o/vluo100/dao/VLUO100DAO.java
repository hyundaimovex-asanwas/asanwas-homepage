package Ehr.vlu.o.vluo100.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;


public class VLUO100DAO extends AbstractDAO {
    /**
     * VLUO100DAO ������
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public VLUO100DAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass�� ������ ȣ�� **/
			super(p_dsId, p_tr);
	}

    /**
     * ��ǥ���� (��ȸ) DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SHR(CBox p_box ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {

				p_box.get("EVL_YYYY"),
                p_box.get("ENO_NO"),
                p_box.get("GOAL_SEQ"),         

		};

		prop.add("SCORE",  ColumnProp.COLUMN_TYPE_DECIMAL, 3.2, ColumnProp.CONSTRAINT_TB_NORMAL);

		prop.add("WEIGHT", ColumnProp.COLUMN_TYPE_DECIMAL, 3.0, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}

	
    /**
     * ������ ��ȸ DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SHR_22(CBox p_box ) throws CException {

		/** �ܺ� XML���� ���κ������� ������ ��ȸ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_22");

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
     * ��ǥ���� (��ȸ) DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SHR_PRT(CBox p_box ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_PRT");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {

				p_box.get("EVL_YYYY"),
                p_box.get("ENO_NO"),
                p_box.get("GOAL_SEQ"),   

		};

		prop.add("WEIGHT", ColumnProp.COLUMN_TYPE_DECIMAL, 3.0, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}	
	
    /**
     * ���κ������� ������ ��ȸ DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SHR_00(CBox p_box ) throws CException {

		/** �ܺ� XML���� ���κ������� ������ ��ȸ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_00");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("GUBUN"),                         // ��������
				p_box.get("EVL_YY"),                        // �ش�⵵
				p_box.get("EVL_GBN"),                     // ��������
				p_box.get("EVL_FRQ"),                     // ȸ��
				p_box.get("ENO_NO")                       // �����ڻ��
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

    /**
     * ������ȸ  DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	
	public GauceDataSet VLUO100_SHR_01(CBox p_box ) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_01");

		//System.out.println(vo);
		//System.out.println(p_box);
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("EVL_YYYY"),                    // �ش�⵵
				p_box.get("ENO_NO")                      // �����ڻ��

		};

		prop.add("STATUS_NM", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

		return this.selectProcess(sql, bind, prop);

	}


	/**
     * ���� �������̺� ��ȸ �� ������ ������ �򰡴�󸮽�Ʈ���� ��ȸ  DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public GauceDataSet VLUO100_SHR_02(CBox p_box ) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				"1"	,													// ��ǥ����
				p_box.get("EVL_YYYY"),                    // �ش�⵵
				"1",                     								// ������
				"1",													// ����(0:Non KPI,1:KPI)
				p_box.get("ENO_NO")                       // �����ڻ��
		};

		prop.add("STATUS", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("STATUS_NM", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REMARK", ColumnProp.COLUMN_TYPE_STRING, 100, ColumnProp.CONSTRAINT_TB_NORMAL);

		return this.selectProcess(sql, bind, prop);

	}

    /**
     * ��ǥ���� �ִ밪 (��ȸ) DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
    public void VLUO100_SHR_01_OLD(CBox p_box ) throws CException {

        /** �ܺ� XML���� ��ǥ���� �ִ밪  (��ȸ) SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_01_OLD");

        /** �˻� ���� Mapping(PrepareStatement ) **/
        Object[] bind = new Object[] {
                p_box.get("GUBUN"),
                p_box.get("EVL_YY"),
                p_box.get("EVL_FRQ"),
                p_box.get("ENO_NO"),
                p_box.get("EVLENO_NO")
        };
        /**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
        this.selectProcessFirstRow(sql, bind, this.prop);

    }

    /**
     * ��ǥ�Է� �Ⱓ ���� (��ȸ) DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
    public GauceDataSet VLUO100_SHR_03(CBox p_box ) throws CException {

        /** �ܺ� XML���� ��ǥ�Է� �Ⱓ ����  (��ȸ) SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_03");

        /** �˻� ���� Mapping(PrepareStatement ) **/
        Object[] bind = new Object[] {
                p_box.get("EVL_YYYY"),
                "1",
                p_box.get("GUBUN"),
                p_box.get("ENO_NO"),
                p_box.get("GOAL_NO")
        };
        /**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
        return this.selectProcess(sql, bind, prop);

    }

    /**
     * �򰡴���� ���� ������ ��ȸ DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SHR_04(CBox p_box ) throws CException {

		/** �ܺ� XML���� �򰡴���� ���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUC130_SHR_00");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("GUBUN"),                        // ��������
				p_box.get("EVL_YY"),                        // �ش�⵵
				p_box.get("EVL_GBN"),                     // ��������
				p_box.get("EVL_FRQ"),                     // ȸ��
				p_box.get("ENO_NO")                       // �����ڻ��
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

    /**
     * ������ ��ȸ DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SHR_YMD(CBox p_box ) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SHR_YMD");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("SESSION_ENONO")),        //�����ȣ
				p_box.get("EVL_YYYY"),                 // �ش�⵵
				"1",									             // ȸ��
				p_box.get("GUBUN"),                    //����(0:Non KPI,1:KPI,2:PM)
				p_box.get("ITEM")                         // ITEM �ڵ�(G:��ǥ�Է�,M:�߰����,C:��ǥ����,S:������,E:������,O:���Ȯ�ι����ǽ�û)
		};

		prop.add("GOAL_NO", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("STATUS_NM", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}
    /**
     * ��ǥ���� (�Է�) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_INS(CBox p_box, GauceValueObject vo ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (�Է�) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_INS");

		//System.out.println(p_box);	
		//System.out.println(vo);
		
		
		/** ���� ����  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVL_YYYY")),				//�ش�⵵
                JSPUtil.rns(vo.get("ENO_NO")), 					//�����ڻ��
                JSPUtil.rns(vo.get("GOAL_SEQ")), 				//GOAL_SEQ                
                JSPUtil.rns(vo.get("GOAL_NO")),					//��ǥ����(�����ø��� ������ �ο�)
                JSPUtil.rns(vo.get("GOAL_SEQ")), 				//GOAL_SEQ                   
                JSPUtil.rns(vo.get("CATEGORY")),             	//������ǥ
                JSPUtil.rns(vo.get("FORMULA")),             	//���θ�ǥ
                JSPUtil.rns(vo.get("GRADE_S")),             	//S
                JSPUtil.rns(vo.get("GRADE_A")),             	//A
                JSPUtil.rns(vo.get("GRADE_B")),             	//B
                JSPUtil.rns(vo.get("GRADE_C")),             	//C
                JSPUtil.rns(vo.get("GRADE_D")),             	//D
                JSPUtil.rns(vo.get("GOALSET_HALF")),    		//��ݱ��ǥ
                JSPUtil.rns(vo.get("GOALSET_10")),    			//10����ǥ                   
                JSPUtil.rns(vo.get("GOALSET")),    				//��ǥ
                JSPUtil.rns(vo.get("WEIGHT")),       			//����

                JSPUtil.rns(p_box.get("vusrid")),        		//�����ȣ
                JSPUtil.rns(vo.get("EVL_YYYY")),				//�ش�⵵
                JSPUtil.rns(vo.get("ENO_NO")), 					//�����ڻ��
                JSPUtil.rns(vo.get("GOAL_SEQ")), 				//GOAL_SEQ                
                JSPUtil.rns(vo.get("GOAL_NO")),					//��ǥ����(�����ø��� ������ �ο�)
                JSPUtil.rns(vo.get("CATEGORY")),             	//ī�װ�
                JSPUtil.rns(vo.get("FORMULA")),             	//���θ�ǥ
                JSPUtil.rns(vo.get("GRADE_S")),             	//S
                JSPUtil.rns(vo.get("GRADE_A")),             	//A
                JSPUtil.rns(vo.get("GRADE_B")),             	//B
                JSPUtil.rns(vo.get("GRADE_C")),             	//C
                JSPUtil.rns(vo.get("GRADE_D")),             	//D
                JSPUtil.rns(vo.get("GOALSET_HALF")),    		//��ݱ��ǥ
                JSPUtil.rns(vo.get("GOALSET_10")),    			//10����ǥ                   
                JSPUtil.rns(vo.get("GOALSET")),       			//��ǥ
                JSPUtil.rns(vo.get("WEIGHT")),       			//����

                'S',											//���°�
                JSPUtil.rns(p_box.get("vusrid")),        		//�����ȣ
                JSPUtil.rns(p_box.get("vusrid"))         		//�����ȣ
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
	public void VLUO100_SAV_01(CBox p_box,  GauceValueObject vo) throws CException {

		/** �ܺ� XML���� ��ǥ���� (�Է�) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_UPT_01");

		/** ���� ����  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid")),         		//�����ȣ      
				JSPUtil.rns(vo.get("EVL_YYYY")),				//�ش�⵵
                JSPUtil.rns(vo.get("ENO_NO")), 					//�����ڻ��
                JSPUtil.rns(vo.get("GOAL_SEQ")),				//��ǥ����  
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
	public void VLUO100_SAV_011(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ǥ���� (�Է�) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_UPT_011");

		/** ���� ����  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid")),         		//�����ȣ      
				JSPUtil.rns(p_box.get("EVL_YYYY")),				//�ش�⵵
                JSPUtil.rns(p_box.get("ENO_NO")), 				//�����ڻ��
                JSPUtil.rns(p_box.get("GOAL_SEQ")),				//��ǥ����  
                
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}		
	
	
    /**
     * ���� �Ǵ� �ΰ� DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_SAV_02(CBox p_box, GauceValueObject vo ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (�Է�) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_SAV_02");

		/** ���� ����  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVL_YYYY")),				//�ش�⵵
                JSPUtil.rns(vo.get("ENO_NO")), 					//�����ڻ��
                JSPUtil.rns(vo.get("GOAL_SEQ")),				//��ǥ����          
                JSPUtil.rns(p_box.get("vusrid")),        		//�����ȣ
                JSPUtil.rns(p_box.get("vusrid"))         		//�����ȣ
		};

		/** INSERT�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}	
	

	
	
    /**
     * ���� ���� ����Ʈ ���� DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_INS_01(CBox p_box, GauceValueObject vo ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (�Է�) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_INS_01");

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
     * ��ǥ���� (����) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_UPT(CBox p_box, GauceValueObject vo ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_UPT");

		/** ���� ���� �� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("CATEGORY")),		//����(0:��KPI����,1:��������)
                JSPUtil.rns(vo.get("KPI")),					//KPI
                JSPUtil.rns(vo.get("FORMULA")),		//�����
                JSPUtil.rns(vo.get("GRADE_S")),     	//S���
                JSPUtil.rns(vo.get("GRADE_A")),      	//A���
                JSPUtil.rns(vo.get("GRADE_B")),      	//B���
                JSPUtil.rns(vo.get("GRADE_C")),		//C���
                JSPUtil.rns(vo.get("GRADE_D")),       //D���
                JSPUtil.rns(vo.get("GOAL_HALF")),        		//��ǥ
                JSPUtil.rns(vo.get("GOAL_10")),        		//��ǥ
                JSPUtil.rns(vo.get("GOAL")),        		//��ǥ
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
     * ��ǥ���� ���λ��� ������Ʈ DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_UPT_01(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_UPT_01");

		/** ���� ���� �� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {

                JSPUtil.rns(p_box.get("STATUS")),					//����(R:�̰�,Y:����,N:�ΰ�)
                JSPUtil.rns(p_box.get("SESSION_ENONO")),	//����������
                JSPUtil.rns(p_box.get("ENO_NO")),     			//�����ڻ��

		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
     * ��ǥ���� ���λ��� ������Ʈ DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_UPT_02(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_UPT_02");

		/** ���� ���� �� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("STATUS")),				//����(S:����, R:���, Y:����, N:�ΰ�)
                JSPUtil.rns(p_box.get("vusrid")),        			//�����ȣ                 
                JSPUtil.rns(p_box.get("EVL_YYYY")),				//�ش�⵵
                JSPUtil.rns(p_box.get("ENO_NO")), 				//�����ڻ�� 
                JSPUtil.rns(p_box.get("GOAL_SEQ")), 			//GOAL_SEQ                 
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
     * ��ǥ���� ���λ��� ������Ʈ DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO100_UPT_03(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_UPT_03");

		/** ���� ���� �� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("STATUS")),				//����(S:����, R:���, Y:����, N:�ΰ�)
                JSPUtil.rns(p_box.get("vusrid")),        			//�����ȣ                 
                JSPUtil.rns(p_box.get("EVL_YYYY")),				//�ش�⵵
                JSPUtil.rns(p_box.get("ENO_NO")), 				//�����ڻ�� 
                JSPUtil.rns(p_box.get("GOAL_SEQ")), 			//GOAL_SEQ                 
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
	public void VLUO100_DEL(CBox p_box, GauceValueObject vo) throws CException {

        //�����ͻ���
		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_DEL");

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
	public void VLUO100_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

        //�����ͻ���
		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO100_DEL_01");

		/** ���� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVL_YYYY")),			//�ش�⵵
                JSPUtil.rns(vo.get("ENO_NO")),     		//�����ڻ��
                JSPUtil.rns(vo.get("GOAL_SEQ")),     	//GOAL_SEQ                
		};
		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}

}
