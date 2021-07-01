package Ehr.eis.t.eist020.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EIST020DAO extends AbstractDAO {
	/**
	 * PIRA060DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EIST020DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}
	
	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EIST020_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM"),				// ���
				p_box.get("TEAM_CD"),				// ��				
				p_box.get("ENO_NO")					// ���
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	

	/**
	 * �Ҽ� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EIST020_SHR_TEAM(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_SHR_TEAM");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
			
				p_box.get("ENO_NO")					// ���
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
	 * ���ں� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EIST020_SHR_DAY(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_SHR_DAY");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM"),				// ���
				p_box.get("TEAM_CD"),				// ��				
				p_box.get("ENO_NO"),				// ���
				p_box.get("STS")					// ����				
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	/**
	 * ������Ʈ�� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EIST020_SHR_PJT(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_SHR_PJT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM"),				// ���
				p_box.get("TEAM_CD"),				// ��				
				p_box.get("ENO_NO"),				// ���
				p_box.get("STS")					// ����	
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	/**
	 * ������ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EIST020_SHR_PER(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_SHR_PER");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM"),				// ���
				p_box.get("TEAM_CD"),				// ��				
				p_box.get("ENO_NO"),				// ���
				p_box.get("STS")					// ����	
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
     * ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_INS(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_INS");
        
        String ymd[] = JSPUtil.rns(vo.get("STR_YMD")).split("-");
        int quarter = 0;
        int month = 0;
        try {
            month = Integer.parseInt(ymd[1]);
        } catch(Exception e) {
            month = 1;
        }
        
        quarter = ((month-1)/3)+1;
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),			//�⵵
                String.valueOf(quarter),			//�б�
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),		//��û������
				JSPUtil.rns(vo.get("END_YMD").replaceAll("-", "")),		//��û������
				JSPUtil.rns(vo.get("PAY_YM").replaceAll("-", "")),		//���޳��
				JSPUtil.rns(vo.get("PAY_YMD").replaceAll("-", "")),		//��������
				p_box.get("vusrid"),
				p_box.get("vusrid")
		};
		

		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);

	}
	
	/**
     * ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT");
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("END_YMD").replaceAll("-", "")),		//��û������
                JSPUtil.rns(vo.get("PAY_YM").replaceAll("-", "")),      //���޳��
                JSPUtil.rns(vo.get("PAY_YMD").replaceAll("-", "")),     //��������
				p_box.get("vusrid"),
				JSPUtil.rns(vo.get("PIS_YY")),			//�⵵
				JSPUtil.rns(vo.get("PIS_QQ")),			//�б�
                JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),     //��û������
		};
		

		/** UPDATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}
	
	
	
	/**
     * ���ں� ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT_DAY(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT_DAY");
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("STATUS"),					// ����, �ݼ�				
                JSPUtil.rns(p_box.get("vusrid")),       // ������				
				//p_box.get("ENO_NO"),					// ����
				JSPUtil.rns(vo.get("ENO_NO")),			// ����				
				JSPUtil.rns(vo.get("REG_YMD")),			// ����
				JSPUtil.rns(vo.get("PJT_CD")),			// ������Ʈ				

		};
				
		/** UPDATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}	
	
	
	/**
     * ���ں� ���� (��ü) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT_DAY_01(CBox p_box, GauceValueObject vo) throws CException {

        //��ť�� ������Ʈ
		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT_DAY_01");

		/** ���� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("STATUS"),									// ����, �ݼ�				
                JSPUtil.rns(p_box.get("vusrid")),       				// ������				
				JSPUtil.rns(vo.get("ENO_NO")),							// ����				
				p_box.get("PIS_YM"),									// ���
		};
		
		/** UPDATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}		
	
	
	/**
     * ������Ʈ�� ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT_PJT(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT_PJT");
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("STATUS"),					// ����, �ݼ�				
                JSPUtil.rns(p_box.get("vusrid")),       // ������				
				//p_box.get("ENO_NO"),					// ����
				JSPUtil.rns(vo.get("ENO_NO")),			// ����				
				JSPUtil.rns(vo.get("REG_YMD")),			// ����
				JSPUtil.rns(vo.get("PJT_CD")),			// ������Ʈ				

		};
				
		/** UPDATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}		
	
	/**
     * ������Ʈ�� ���� (��ü) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT_PJT_01(CBox p_box, GauceValueObject vo) throws CException {

        //��ť�� ������Ʈ
		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT_PJT_01");

		/** ���� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("STATUS"),									// ����, �ݼ�				
                JSPUtil.rns(p_box.get("vusrid")),       				// ������				
				JSPUtil.rns(vo.get("ENO_NO")),							// ����				
				p_box.get("PIS_YM"),									// ���
		};
		
		/** UPDATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}	
	
	
	/**
     * ���κ� ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT_PER(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT_PER");
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("STATUS"),					// ����, �ݼ�				
                JSPUtil.rns(p_box.get("vusrid")),       // ������				
				//p_box.get("ENO_NO"),					// ����
				JSPUtil.rns(vo.get("ENO_NO")),			// ����				
				JSPUtil.rns(vo.get("REG_YMD")),			// ����
				JSPUtil.rns(vo.get("PJT_CD")),			// ������Ʈ				

		};
				
		/** UPDATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}		
	
	/**
     * ���κ� ���� (��ü) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT_PER_01(CBox p_box, GauceValueObject vo) throws CException {

        //��ť�� ������Ʈ
		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT_PER_01");

		/** ���� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("STATUS"),									// ����, �ݼ�				
                JSPUtil.rns(p_box.get("vusrid")),       				// ������				
				JSPUtil.rns(vo.get("ENO_NO")),							// ����				
				p_box.get("PIS_YM"),									// ���
		};
		
		/** UPDATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}		
	
	
	/**
     * ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_DEL(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_DEL");
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),			//�⵵
				JSPUtil.rns(vo.get("PIS_QQ")),			//�б�
                JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),     //��û������
		};
		

		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}
	

}
