package Ehr.sch.a.scha090.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class SCHA090DAO extends AbstractDAO {
	/**
	 * PIRA060DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SCHA090DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}
	
	/**
	 * ���ڱ� ��û�Ⱓ ���� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void SCHA090_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ���ڱ� ��û�Ⱓ ���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA090_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),				// �⵵
				p_box.get("PIS_QQ")				// �б�
		};
		
		prop.add("PIS_YY",  ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("STR_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("END_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("PAY_YM",  ColumnProp.COLUMN_TYPE_STRING, 7, ColumnProp.CONSTRAINT_TB_NOTNULL);
        prop.add("PAY_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);


		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	
	public void SCHA090_SHR2(CBox p_box) throws CException {

		/** �ܺ� XML���� ���ڱ� ��û�Ⱓ ���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA090_SHR2");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {

		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
     * ���ڱ� ��û�Ⱓ ���� ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void SCHA090_INS(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� ���ڱ� ��û�Ⱓ ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA090_INS");
        
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
     * ���ڱ� ��û�Ⱓ ���� ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void SCHA090_UPT(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� ���ڱ� ��û�Ⱓ ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA090_UPT");
		
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
     * ���ڱ� ��û�Ⱓ ���� ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void SCHA090_DEL(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� ���ڱ� ��û�Ⱓ ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA090_DEL");
		
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
