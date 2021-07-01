package Ehr.eis.t.eist050.dao;

import oracle.jdbc.OracleTypes;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EIST050DAO extends AbstractDAO {
	/**
	 * PIRA060DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EIST050DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}
	
	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EIST050_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST050_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM").substring(0, 4),				// ��	
				p_box.get("PIS_YM").substring(5, 7),				// ��					
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EIST050_SHR_TEAM(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST050_SHR_TEAM");

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
	public void EIST050_SAV(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST050_SAV");
        
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				
				
				p_box.get("PIS_YM").substring(0, 4),				// ��	
				p_box.get("PIS_YM").substring(5, 7),				// ��
				
				JSPUtil.rns(vo.get("ENO_NO")),			
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("ENO_NO")),
				

				JSPUtil.rns(vo.get("SAL_AMT")),             
				JSPUtil.rns(vo.get("RET_AMT")),
				JSPUtil.rns(vo.get("INS_AMT")),
				JSPUtil.rns(vo.get("LUN_AMT")),             
				JSPUtil.rns(vo.get("WEL_AMT")),
				JSPUtil.rns(vo.get("O7_AMT")),
				JSPUtil.rns(vo.get("BUS_AMT")),             
				JSPUtil.rns(vo.get("PARK_AMT")),
				JSPUtil.rns(vo.get("OIL_AMT")),				
				
				JSPUtil.rns(vo.get("SAL_AMT")),             
				JSPUtil.rns(vo.get("RET_AMT")),
				JSPUtil.rns(vo.get("INS_AMT")),
				JSPUtil.rns(vo.get("LUN_AMT")),             
				JSPUtil.rns(vo.get("WEL_AMT")),
				JSPUtil.rns(vo.get("O7_AMT")),
				JSPUtil.rns(vo.get("BUS_AMT")),             
				JSPUtil.rns(vo.get("PARK_AMT")),
				JSPUtil.rns(vo.get("OIL_AMT")),				
				
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				
				
		};

        
		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);

	}
	
	
	/**
     * ����ϴ� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST050_INS_01(GauceValueObject vo, CBox p_box ) throws CException {

		//System.out.println("vo22========="+vo);
		//System.out.println("p_box22========="+p_box);		
		/** �ΰǺ� ��� ��Ű�� ����  **/
		String sql = "{ call PMS.PKG_XF_EIST050.SF_INS_TTX(?, ?, ?, ?) }";

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
		Object[][] bind = new Object[][] {
				{"IN", 			"", 				JSPUtil.rns(vo.get("PIS_YY")), 			""						},//��
				{"IN", 			"", 				JSPUtil.rns(vo.get("PIS_MM")), 			""						},//��
				{"IN",			"", 				JSPUtil.rns(p_box.get("vusrid")),		""						},//�۾���
				{"IN/OUT", 		"MSG", 				"MSG", 									String.valueOf(OracleTypes.VARCHAR)} //�۾��Ϸ�޼���
		};

		/** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
		CBox box = (CBox)this.executeProcedure(sql, bind, null);		
		
	}	
	
	
	/**
     * ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST050_UPT(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST050_UPT");
		
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
	public void EIST050_DEL(CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST050_DEL");
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM").substring(0, 4),				// ��	
				p_box.get("PIS_YM").substring(5, 7),				// ��

		};
		

		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}
	

}
