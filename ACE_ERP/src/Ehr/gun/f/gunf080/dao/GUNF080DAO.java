package Ehr.gun.f.gunf080.dao;

import Ehr.common.util.JSPUtil;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF080DAO extends AbstractDAO {
	/**
	 * GUND060DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNF080DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ���  ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {		
				
				p_box.get("DPT_CD"),					
				p_box.get("ENO_NO"),					
				
		};
		
		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}
	
	
	/**
	 * ������  ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR_01(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),				
				p_box.get("ENO_NO"),
				p_box.get("ENO_NO"),
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),				
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),				
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),				
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),				
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),				
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),				
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),					
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),					
				
				p_box.get("ENO_NO"),
				p_box.get("PIS_YM"),

		};

		prop.add("DAY_TOTAL_TIME", ColumnProp.COLUMN_TYPE_DECIMAL, 3.2, ColumnProp.CONSTRAINT_TB_NORMAL);		
		
		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}		
	
	
	
	/**
	 * �����ð�  ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR_DTL(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR_DTL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),
				p_box.get("WEEK_NO"),	
				p_box.get("ENO_NO"),
				p_box.get("WEEK_NO"),		
				p_box.get("ENO_NO"),
				p_box.get("WEEK_NO"),	
				p_box.get("ENO_NO"),
				p_box.get("WEEK_NO"),	
				p_box.get("ENO_NO"),
				p_box.get("PIS_YM"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YM"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YM"),
		};

		prop.add("WEEK_TOTAL_TIME", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);	
		prop.add("POSIBLE_TIME", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);		
		
		prop.add("MONTH_TOTAL_TIME", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);	
		prop.add("POSIBLE_TIME2", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);			
		
		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}		
	
	
	/**
	 * �ڵ����缱 ��ȸ  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR_APP(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR_APP");

		/** ��ȸ ����(����2)�� ���� ó�� #2  ����**/
		StringBuffer sb1 = new StringBuffer();

		// ���繫�� - �λ�����
		if (p_box.get("TEAM_CD").equals("CC11")) {
			
			sb1.append("AND B.DPT_CD = 'CC10'\n");
			sb1.append("AND B.DUTY_CD = '41'");
			
		// ����� �繫�� - �λ�����
		} else if (p_box.get("TEAM_CD").equals("CC12")) {
			
			sb1.append("AND B.DPT_CD = 'CC10'\n");
			sb1.append("AND B.DUTY_CD = '41'");
			
		// ��õ�鼼�� - �鼼�������	
		} else if (p_box.get("TEAM_CD").equals("KK66")) {
			
			sb1.append("AND B.DPT_CD = 'KK65'\n");	
			sb1.append("AND B.DUTY_CD = '41'");
			
		// �����뱳 - �������
		} else if (p_box.get("TEAM_CD").equals("I233")) {
			
			sb1.append("AND B.TEAM_CD = 'I233'\n");	
			sb1.append("AND B.DUTY_CD = '20'");			
			
		// ���׾ȵ� - �������
		} else if (p_box.get("TEAM_CD").equals("I364")) {
			
			sb1.append("AND B.TEAM_CD = 'I364'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
			
		// �¾ȹ��� - �������
		} else if (p_box.get("TEAM_CD").equals("I361")) {
			
			sb1.append("AND B.TEAM_CD = 'I361'\n");	
			sb1.append("AND B.DUTY_CD = '20'");			
		
		// �μ����� - �������
		} else if (p_box.get("TEAM_CD").equals("I356")) {
			
			sb1.append("AND B.TEAM_CD = 'I356'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
			
		// �ź��ϼ� - �������
		} else if (p_box.get("TEAM_CD").equals("I355")) {
			
			sb1.append("AND B.TEAM_CD = 'I355'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
			
		// õ�ȿ�ȸ - ���������
		} else if (p_box.get("TEAM_CD").equals("I347")) {
			
			sb1.append("AND B.DPT_CD = 'II20'\n");	
			sb1.append("AND B.DUTY_CD = '41'");	
			
		// ����ɰ� - �������
		} else if (p_box.get("TEAM_CD").equals("I192")) {
			
			sb1.append("AND B.TEAM_CD = 'I192'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
			
		// ���갭�� - ���������
		} else if (p_box.get("TEAM_CD").equals("I171")) {
			
			sb1.append("AND B.DPT_CD = 'II20'\n");	
			sb1.append("AND B.DUTY_CD = '41'");	
			
		// �Ⱦ���ǽ��� - �������
		} else if (p_box.get("TEAM_CD").equals("I374")) {
			
			sb1.append("AND B.TEAM_CD = 'I374'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
			
		// �������̽��� - �������
		} else if (p_box.get("TEAM_CD").equals("I373")) {
			
			sb1.append("AND B.TEAM_CD = 'I373'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
						
		// �Ｚ���������� - �������
		} else if (p_box.get("TEAM_CD").equals("I372")) {
			
			sb1.append("AND B.TEAM_CD = 'I372'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
			
		// �������� - �������
		} else if (p_box.get("TEAM_CD").equals("I371")) {
			
			sb1.append("AND B.TEAM_CD = 'I371'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
				
		// ��õ��Ȱ���� - ������� (�������� ����)
		} else if (p_box.get("TEAM_CD").equals("I369")) {
			
			sb1.append("AND B.TEAM_CD = 'I386'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
					

		// ���̵� - �������
		} else if (p_box.get("TEAM_CD").equals("I368")) {
			
			sb1.append("AND B.TEAM_CD = 'I368'\n");	
			sb1.append("AND B.DUTY_CD = '20'");			
			
		// �Ｚ���ְź��� - �������
		} else if (p_box.get("TEAM_CD").equals("I366")) {
			
			sb1.append("AND B.TEAM_CD = 'I366'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
			
		// ������������ - �������
		} else if (p_box.get("TEAM_CD").equals("I362")) {
			
			sb1.append("AND B.TEAM_CD = 'I362'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
			
		// ����� �켮������ - �������
		} else if (p_box.get("TEAM_CD").equals("I360")) {
			
			sb1.append("AND B.TEAM_CD = 'I360'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
		
		// �������� - �������
		} else if (p_box.get("TEAM_CD").equals("I358")) {
			
			sb1.append("AND B.TEAM_CD = 'I358'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
			
		// ����� - �������
		} else if (p_box.get("TEAM_CD").equals("I353")) {
			
			sb1.append("AND B.TEAM_CD = 'I353'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
			
			
		} else {
			
			sb1.append("AND A.DPT_CD = B.DPT_CD\n");
			sb1.append("AND B.DUTY_CD = '41'");
			
		}
		
		
		Object[] sqlParam = new Object[] {
				
				sb1.toString(),
		
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("ENO_NO"))
		};

		 this.selectProcessFirstRow(sql, bind, prop);
		
	}		
	
	
	
	/**
	 * ���� ��� ���� ��ȣ ä��  ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR_MAX(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR_MAX");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}	
	
	
	/**
	 * ���� ��� ���� ��ȣ ä��  ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR_MAX2(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR_MAX2");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}		
	

	/**
	 * ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR_REQ(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR_REQ");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO"),          // ���	
				p_box.get("REQ_NO"),		  // REQ_NO
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}		
	
	/**
	 * ���κ� �ٹ����� �Է�
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
		public void GUNF080_SAV(GauceValueObject vo, CBox p_box) throws CException {

			
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_INS");	

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),          // ���	
				vo.get("REG_YMD"),            // ����	
				vo.get("WEEK_NO"),            // ����
				vo.get("STR_TIME"),           // �ٹ����۽ð�
				vo.get("STR_MINUTE"),         // �ٹ����۽ð�				
				vo.get("END_TIME"),           // �ٹ�����ð�
				vo.get("END_MINUTE"),         // �ٹ�����ð�	
				vo.get("DAY_TOTAL_TIME"),     // �Ϸ�ٹ��ð�
				//vo.get("STATUS_NOW"),       // STATUS_NOW
				p_box.get("vusrid"),		  // �Է���		
				p_box.get("vusrid"),		  // ������	
			
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);		
		
	}
		
		

		/**
		 * ���κ� �ٹ����� �Է�
		 * @param p_box
		 * @param vo		GauceValueObject
		 * @throws CException
		 */
			public void GUNF080_UPT(GauceValueObject vo, CBox p_box) throws CException {

				
			/** �ܺ� XML���� SQL�� �о� �´� **/
			String sql = XmlSqlUtils.getSQL("gun", "GUNF080_UPT");

			//System.out.println(p_box);

			/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
			Object[] bind = new Object[] {
					p_box.get("ENO_NO"),          // ���	
					vo.get("REG_YMD"),            // ����	
					vo.get("WEEK_NO"),            // ����
					vo.get("STR_TIME"),           // �ٹ����۽ð�
					vo.get("STR_MINUTE"),         // �ٹ����۽ð�				
					vo.get("END_TIME"),           // �ٹ�����ð�
					vo.get("END_MINUTE"),         // �ٹ�����ð�	
					vo.get("DAY_TOTAL_TIME"),     // �Ϸ�ٹ��ð�
					//vo.get("STATUS_NOW"),         // STATUS_NOW					
					p_box.get("vusrid"),		  // �Է���		
					p_box.get("vusrid"),		  // ������	
				
			};

			/** INSERT�޼ҵ� ȣ��  **/
			insertProcess(sql, bind);		
			
		}			
		
		
	
	/**
	 * ���κ� �ٹ����¸� �����ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				vo.get("REG_YMD"),            // �ٹ�����
				vo.get("ENO_NO"),             // ���				
				
		};

		/** INSERT�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}
	
	
	
	/**
	 * ���� ��� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_UPT_APP(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_UPT_APP");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),          	// REQ_NO	
				p_box.get("vusrid"),     		// ������				
				vo.get("ENO_NO"),          		// ���	 
				vo.get("REG_YMD"),          	// ��¥	 
		};

		/** UPDATE �޼ҵ� ȣ��  **/
		updateProcess(sql, bind);		

	}		
	
	
	/**
	 * ���� ��� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_UPT_APP_EACH(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_UPT_APP_EACH");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),          	// REQ_NO	
				p_box.get("vusrid"),     		// ������				
				vo.get("ENO_NO"),          		// ���	 
				vo.get("REG_YMD"),          	// ��¥	 
		};

		/** UPDATE �޼ҵ� ȣ��  **/
		updateProcess(sql, bind);		

	}		
	
	
	
	/**
	 * ���� ���̺� �Է� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_UPT_APP_01(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_UPT_APP_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(p_box.get("REQ_NO")),
				JSPUtil.rns(vo.get("DPT_CD")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("HENO_NO")),
				JSPUtil.rns(vo.get("HJOB_CD")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")+"00",

		};

		/** UPDATE �޼ҵ� ȣ��  **/
		updateProcess(sql, bind);		

	}	

	
	/**
	 * ���� ���̺� �Է� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_UPT_APP_01_EACH(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_UPT_APP_01_EACH");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(p_box.get("REQ_NO")),
				JSPUtil.rns(vo.get("DPT_CD")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("HENO_NO")),
				JSPUtil.rns(vo.get("HJOB_CD")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("GUN_YMD")),

		};

		/** UPDATE �޼ҵ� ȣ��  **/
		updateProcess(sql, bind);		

	}	
	
	
}
