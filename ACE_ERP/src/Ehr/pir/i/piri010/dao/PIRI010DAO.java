package Ehr.pir.i.piri010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRI010DAO extends AbstractDAO {
	/**
	 * SCHA010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRI010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}


	
	/**
	 * ��������ó�� ���� ��� �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 */
	public void PIRI010_SHR_ACC(CBox p_box) throws CException {

		/** ���α׷� ��� �α� ������ ����Ѵ� **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"piri010",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"S"
		};

		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);		
		
	}		
	
	
	
	/**
	 * �μ� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void PIRI010_SHR_01(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRI010_SHR_01");

		/** ���� ���п� ���� ó�� **/
		StringBuffer sb = new StringBuffer();
		
		if ( p_box.get("END_YN").equals("1") ) {
			sb.append("AND    (RET_YMD IS NULL OR RET_YMD >= SYSDATE) \n");
		}else{
			sb.append("");
		}

		//System.out.print(p_box);

		//��������� �߰���. �ش纻���常 ���̰�, �迵�� ������ �������� T/F�� ���̵���
		StringBuffer sb3 = new StringBuffer();

		if ( !p_box.get("SESSION_ROLE_CD").equals("1001") && !p_box.get("SESSION_ROLE_CD").equals("1002")
				&& p_box.get("SESSION_ROLE_CD").equals("2021") ) {

			if ( p_box.get("SESSION_ENONO").equals("1990016") ) {
				sb3.append("AND   (HEAD_CD = 'K000' OR DPT_CD = 'A480') ");

			}else if ( p_box.get("SESSION_ENONO").equals("1990017") ) {
					sb3.append("AND   1=1 ");							
					
			}else{
				
				sb3.append("AND    HEAD_CD = '"+p_box.get("SESSION_HEADCD")+"'");
			}			

			
		}

		//��������� �߰���. �ش纻���常 ���̰�
		StringBuffer sb4 = new StringBuffer();

		if ( !p_box.get("SESSION_ROLE_CD").equals("1001") && !p_box.get("SESSION_ROLE_CD").equals("1002")
				&& p_box.get("SESSION_ROLE_CD").equals("2022") && !p_box.get("SESSION_ENONO").equals("2070037")) {
			sb4.append("AND    DPT_CD = '"+p_box.get("SESSION_DPTCD")+"'");

		}else if ( p_box.get("SESSION_ENONO").equals("2070037") ) {
		
			sb4.append("AND    HEAD_CD = '"+p_box.get("SESSION_HEADCD")+"'");		
		}
	
		
		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb3.toString(),
				sb4.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				//p_box.get("SESSION_GUBUN")
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ��� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void PIRI010_SHR_02(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRI010_SHR_02");

		/** ���� ���п� ���� ó�� **/
		StringBuffer sb = new StringBuffer();
		if ( p_box.get("END_YN").equals("1") ) {
			sb.append("AND    RET_YMD IS NULL \n");
		}else{
			sb.append("");
		}


		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				//p_box.get("SESSION_GUBUN"),
				p_box.get("DPT_CD")
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	

	public void PIRI010_SHR_DUTY(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRI010_SHR_DUTY");




		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		//sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO")
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}	

}
