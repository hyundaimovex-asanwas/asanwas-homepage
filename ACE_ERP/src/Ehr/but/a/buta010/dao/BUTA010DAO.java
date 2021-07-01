package Ehr.but.a.buta010.dao;

import java.io.FileOutputStream;
import java.io.IOException;

import com.gauce.GauceDataSet;
import com.shift.gef.configuration.Configuration;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.CommUtil;
import Ehr.common.util.JSPUtil;

public class BUTA010DAO extends AbstractDAO {

	/**
	 * BUTA010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public BUTA010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ����ǰ�� ��Ȳ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA010_SHR(CBox p_box) throws CException {

		String STR_YMD = p_box.get("STR_YMD").replaceAll("-", "");
		String END_YMD = p_box.get("END_YMD").replaceAll("-", "");

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA010_SHR");


		/** ��ȸ ����(����2)�� ���� ó�� #2  ����**/
		StringBuffer sb1 = new StringBuffer();


		//���
		if (p_box.get("GBN2").equals("2")) {
			sb1.append("AND    B.APP_COMP = 'N'\n");
			sb1.append("AND    B.APP_CMT LIKE '���%' \n");
		}
		
		
		//����Ϸ�
		else if (p_box.get("GBN2").equals("3")) {
			sb1.append("AND    B.APP_COMP = 'Y'");
			
			
		//�ΰ�
		}else if (p_box.get("GBN2").equals("4")) {
			sb1.append("AND    B.APP_COMP = 'N'\n");
			sb1.append("AND    B.APP_CMT LIKE '�ΰ�%' \n");
			
			
		//�ݼ�
		}else if (p_box.get("GBN2").equals("5")) {
			sb1.append("AND    B.APP_COMP = 'N'\n");
			sb1.append("AND    B.APP_CMT LIKE '�ݼ�%' \n");

			
		//ALL
		}else {
			
			sb1.append("");
			
		}

		/** ��ȸ ����(����1)�� ���� ó�� #3 **/
		StringBuffer sb2 = new StringBuffer();

		if (p_box.get("GBN1").equals("3")) {
			
			sb2.append("AND    A.APP_YN <> 'Y'\n");
		}
		
		else if (p_box.get("GBN1").equals("2")) {
			
			sb2.append("AND    A.APP_YN = 'Y'\n");
			
		}else {
			
			sb2.append("");
			
		}

		/* ���� ��αԾ�&������ ����ǰ�Ǽ� ��� ��ȸ�Ҽ��ְ� �ݿ� 20140630 */
		StringBuffer sb3 = new StringBuffer();

		String vusrid = JSPUtil.rns(p_box.get("vusrid"));

		//System.out.println("==================="+p_box);
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vfdname")));	
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vusrnm")));		
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vconame")));			
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vdeptnm")));		
		
		
		if(!p_box.get("vusrid").equals("6180022") && !p_box.get("vusrid").equals("2130010") && !p_box.get("vusrid").equals("6060002") && !p_box.get("vusrid").equals("2130013") &&  !p_box.get("vusrid").equals("2180001")  && !p_box.get("vusrid").equals("2070020")&& !p_box.get("vusrid").equals("6180001") && !p_box.get("vusrid").equals("2200022")){
			 sb3.append("AND   (PENO_NO = '"+ vusrid + "' OR A.ENO_NO = '"+ vusrid +"') \n");
		}else{
			 sb2.append("AND   1 =1  \n");
		}


		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb1.toString(),
				sb2.toString(),
				sb3.toString(),

		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),
				p_box.get("OUR_MAN"),
				STR_YMD,
				END_YMD,
				STR_YMD,
				END_YMD,
		};
		prop.add("APP_YN_NM", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
     * ����ǰ�Ǽ� ���� DAO �޼���
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA010_DEL_01(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA010_DEL_01");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("REQ_NO"),
				vo.get("PENO_NO")
		};


		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}

	/**
     * ����ǰ�Ǽ�������Ȳ ���� DAO �޼���
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA010_DEL_02(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA010_DEL_02");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("REQ_NO"),
				vo.get("PENO_NO")
		};


		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}

	/**
     * �����꼭 ���� DAO �޼���
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA010_DEL_03(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA010_DEL_03");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("REQ_NO")
		};


		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}

	/**
     * ������������� ���� DAO �޼���
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA010_DEL_04(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA010_DEL_04");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("REQ_NO")
		};


		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}


}

