package Ehr.eis.t.eist070.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EIST070DAO extends AbstractDAO {
	/**
	 * PIRA060DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EIST070DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}
	
	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EIST070_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST070_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM").substring(0, 4),				// ��	
				p_box.get("PIS_YM").substring(5, 7),				// ��
				p_box.get("PJT_CD"),								// ������Ʈ	
				p_box.get("TEAM_CD"),								// ��				
				p_box.get("ENO_NO"),								// ���					
				
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	
	/**
	 * ������Ʈ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EIST070_SHR_PJT(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST070_SHR_PJT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
			
				
				JSPUtil.rns(p_box.getString("COMM_CD")),								// ������Ʈ	
				JSPUtil.rns(p_box.getString("COMM_CD")),								// ������Ʈ	
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
     * ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST070_INS(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST070_INS");
        
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PJT_CD")),			//������Ʈ �ڵ�
				JSPUtil.rns(vo.get("PJT_NM")),			//������Ʈ ��		
				JSPUtil.rns(vo.get("DPT_CD")),			//�� �ڵ�
				JSPUtil.rns(vo.get("SEQ")),				//����
				JSPUtil.rns(vo.get("FROM_YMD")),		//��������				
				JSPUtil.rns(vo.get("TO_YMD")),			//��������
				JSPUtil.rns(vo.get("USEYN")),			//��뿩��
		};

        
		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);

	}
	
	
	/**
     * ����ϴ� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST070_INS_01(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST070_INS_01");
        
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PJT_CD")),			//������Ʈ �ڵ�
				JSPUtil.rns(vo.get("PJT_NM")),			//������Ʈ ��		
				JSPUtil.rns(vo.get("DPT_CD")),			//�� �ڵ�
				JSPUtil.rns(vo.get("SEQ")),				//����
				JSPUtil.rns(vo.get("FROM_YMD")),		//��������				
				JSPUtil.rns(vo.get("TO_YMD")),			//��������
				JSPUtil.rns(vo.get("USEYN")),			//��뿩��
		};

        
		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);

	}	
	
	/**
     * ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST070_UPT(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST070_UPT");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("FROM_YMD")),		//������
                JSPUtil.rns(vo.get("TO_YMD")),      	//������
                JSPUtil.rns(vo.get("USEYN")),     		//��� ����
				JSPUtil.rns(vo.get("PJT_CD")),			//�� �ڵ�
				JSPUtil.rns(vo.get("DPT_CD")),			//������Ʈ �ڵ�
		};
		

		/** UPDATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}
	
	/**
     * ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST070_DEL(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST070_DEL");
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),			//�⵵
				JSPUtil.rns(vo.get("PIS_QQ")),			//�б�

		};
		

		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}
	

}
