package Ehr.eis.t.eist030.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EIST030DAO extends AbstractDAO {
	/**
	 * PIRA060DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EIST030DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}
	
	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EIST030_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST030_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("DPT_CD"),				// ��
				p_box.get("PIS_YM"),				// ���
				p_box.get("PIS_YM"),				// ���				
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EIST030_SHR_TEAM(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST030_SHR_TEAM");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO")					// ���
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
     * ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST030_INS(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST030_INS");
        
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
	public void EIST030_UPT(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST030_UPT");
		
		System.out.println("vo========="+vo);
		
		
		
		
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
	public void EIST030_DEL(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST030_DEL");
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),			//�⵵
				JSPUtil.rns(vo.get("PIS_QQ")),			//�б�

		};
		

		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}
	

}
