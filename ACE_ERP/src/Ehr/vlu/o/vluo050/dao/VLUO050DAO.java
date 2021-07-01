package Ehr.vlu.o.vluo050.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;


public class VLUO050DAO extends AbstractDAO {
    /**
     * VLUO050DAO ������
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public VLUO050DAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass�� ������ ȣ�� **/
			super(p_dsId, p_tr);
	}

    /**
     * ���� ����Ʈ (��ȸ) DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO050_SHR(CBox p_box ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO050_SHR");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {

				p_box.get("EVL_YYYY"),
				p_box.get("TEAM_CD"),				
                p_box.get("ENO_NO"),
                p_box.get("STATUS"),         
                p_box.get("SEQ"),  
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}


    /**
     * �� ��ȸ DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO050_SHR_TEAM(CBox p_box ) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO050_SHR_TEAM");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO"),                    //�����ȣ
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}
	
	
    /**
     * ��ǥ���� (�Է�) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO050_INS(CBox p_box, GauceValueObject vo ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (�Է�) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO050_INS");

		/** ���� ����  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVL_YYYY")),				//�ش�⵵
                JSPUtil.rns(vo.get("ENO_NO")), 					//�����ڻ��
                JSPUtil.rns(vo.get("GOAL_NO")),					//��ǥ����(�����ø��� ������ �ο�)
                JSPUtil.rns(vo.get("CATEGORY")),             	//������ǥ
                JSPUtil.rns(vo.get("FORMULA")),             	//���θ�ǥ
                JSPUtil.rns(vo.get("GOALSET")),    				//��ǥ
                JSPUtil.rns(vo.get("WEIGHT")),       			//����
                JSPUtil.rns(vo.get("DIFFICULTY")),       		//���̵�
                JSPUtil.rns(p_box.get("vusrid")),        		//�����ȣ
                JSPUtil.rns(vo.get("EVL_YYYY")),				//�ش�⵵
                JSPUtil.rns(vo.get("ENO_NO")), 					//�����ڻ��
                JSPUtil.rns(vo.get("GOAL_NO")),					//��ǥ����(�����ø��� ������ �ο�)
                JSPUtil.rns(vo.get("CATEGORY")),             	//ī�װ�
                JSPUtil.rns(vo.get("FORMULA")),             	//���θ�ǥ
                JSPUtil.rns(vo.get("GOALSET")),       			//��ǥ
                JSPUtil.rns(vo.get("WEIGHT")),       			//����
                JSPUtil.rns(vo.get("DIFFICULTY")),       		//���̵�                
                JSPUtil.rns(p_box.get("vusrid")),        		//�����ȣ
                JSPUtil.rns(p_box.get("vusrid"))         		//�����ȣ
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
	public void VLUO050_UPT(CBox p_box, GauceValueObject vo ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO050_UPT");

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


}
