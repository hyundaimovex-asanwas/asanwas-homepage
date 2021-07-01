package Ehr.cdp.a.book010.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class BOOK010DAO extends AbstractDAO {

	/**
	 * BOOK010AO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public BOOK010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}


	/**
	 * �������Խ�û ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void BOOK010_SHR(CBox p_box) throws CException {

		
		System.out.print("p_box::::::::::::::::"+p_box);
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SHR");


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	/**
	 * �������Խ�û ������  ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void BOOK010_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/

		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}



	/**
	 * �������Խ�û��ȣ  ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void BOOK010_SHR_03(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SHR_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}



	/**
	 * �������Խ�û �ű� Master ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_INS(CBox p_box, GauceValueObject vo) throws CException {

        //System.out.println("p_box:::::::::::::::::::::"+p_box);

        //System.out.println("vo:::::::::::::::::::::"+vo); 
		
		/** �ܺ� XML���� SQL�� �о� �´� * */
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		        ,JSPUtil.rns(vo.get("RQST_REMARK" ))
                ,vo.get("DPT_CD")                 //�ҼӰ����̳�...
                ,"R"
				,vo.get("ENO_NO")
				,vo.get("ENO_NO")
		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);
	}



	/**
	 * �������Խ�û �ű� Detail ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_INS_02(CBox p_box, GauceValueObject vo) throws CException {

		//System.out.print(p_box);
		//System.out.print(vo);

		/** �ܺ� XML���� SQL�� �о� �´� * */
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_INS_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		        ,JSPUtil.rns(vo.get("RQST_SEQ" ))
		        ,JSPUtil.rns(vo.get("BOOK_NM" ))
		        ,JSPUtil.rns(vo.get("BOOK_PUL" ))
		        ,JSPUtil.rns(vo.get("BOOK_WRT" ))
		        ,JSPUtil.rns(vo.get("BOOK_QTY" ))
		        ,JSPUtil.rns(vo.get("BOOK_AMT" ))
		        ,JSPUtil.rns(vo.get("BOOK_REMARK" ))
				,p_box.get("vusrid")
				,p_box.get("vusrid")
		        ,JSPUtil.rns(vo.get("HOMEPAGE" ))
		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);
	}



	/**
	 * ���缱 ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void BOOK010_SHR_APP(CBox p_box) throws CException {


		System.out.print(p_box);

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SHR_APP");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
    			JSPUtil.rns(p_box.get("REQ_NO")),    	
    			JSPUtil.rns(p_box.get("REQ_NO"))       			
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

		//return this.selectProcess(sql, bind, prop);

	}



	/**
	 * ���缱 ���� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_DEL2(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_DEL2");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				 p_box.get("REQ_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}



	/**
	 * ���缱�� ó�� �����Ѵ�.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_SAV_APP1(CBox p_box, GauceValueObject vo) throws CException {


		//System.out.print(vo);

		/** �ܺ� XML���� SQL�� �о� �´� * */
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SAV_APP");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
		Object[] bind = new Object[] {
                 JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", "")
                ,JSPUtil.rns(vo.get("GUN_GBN"))
                ,JSPUtil.rns(vo.get("DPT_CD"))
                ,p_box.get("vusrid")
                ,p_box.get("REQ_NO")
                ,"R"
                ,JSPUtil.rns(vo.get("SEQ_NO" ))
                ,JSPUtil.rns(vo.get("ENO_NO" ))
                ,JSPUtil.rns(vo.get("JOB_CD" ))
                ,p_box.get("vusrid")
                ,p_box.get("vusrid")

		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);
	}


	/**
	 * ���ó���� �ϸ鼭 ���缱�� �ٽ� �����Ѵ�.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_SAV_APP2(CBox p_box, GauceValueObject vo) throws CException {


		//System.out.print(vo);

		/** �ܺ� XML���� SQL�� �о� �´� * */
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SAV_APP");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
		Object[] bind = new Object[] {
                 JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", "")
                ,JSPUtil.rns(vo.get("GUN_GBN"))
                ,JSPUtil.rns(vo.get("DPT_CD"))
                ,p_box.get("vusrid")
                ,p_box.get("REQ_NO")
                ,"A"
                ,JSPUtil.rns(vo.get("SEQ_NO" ))
                ,JSPUtil.rns(vo.get("ENO_NO" ))
                ,JSPUtil.rns(vo.get("JOB_CD" ))
                ,p_box.get("vusrid")
                ,p_box.get("vusrid")

		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);
	}


	/**
	 * �������Խ�û ���¸� ������� �ٲ۴�.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_UPT_MST(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� * */
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_UPT_MST");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
		Object[] bind = new Object[] {
                p_box.get("REQ_NO")
		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);
	}






	/**

	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "BOOK010_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				 JSPUtil.rns(vo.get("STR_HOL_HOUR"))
		        ,JSPUtil.rns(vo.get("STR_HOL_MIN" ))
		        ,JSPUtil.rns(vo.get("END_HOL_HOUR"))
	            ,JSPUtil.rns(vo.get("END_HOL_MIN" ))
			    ,JSPUtil.rns(vo.get("STR_HOL_HOUR"))
		        ,JSPUtil.rns(vo.get("STR_HOL_MIN" ))
		        ,JSPUtil.rns(vo.get("END_HOL_HOUR"))
	            ,JSPUtil.rns(vo.get("END_HOL_MIN" ))
				,JSPUtil.rns(vo.get("STR_HOL_HOUR"))
		        ,JSPUtil.rns(vo.get("STR_HOL_MIN" ))
		        ,JSPUtil.rns(vo.get("END_HOL_HOUR"))
	            ,JSPUtil.rns(vo.get("END_HOL_MIN" ))

	            ,JSPUtil.rns(vo.get("STR_HOL_HOUR"))
	            ,JSPUtil.rns(vo.get("STR_HOL_MIN" ))
	            ,JSPUtil.rns(vo.get("END_HOL_HOUR"))
	            ,JSPUtil.rns(vo.get("END_HOL_MIN" ))

	            ,JSPUtil.rns(vo.get("REMARK"      ))
				,p_box.get("vusrid")
				,JSPUtil.rns(vo.get("HOL_YMD"     )).replaceAll("-", "")
                ,JSPUtil.rns(vo.get("ENO_NO"      ))
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}



	/**
	 * ������û ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "BOOK010_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("HOL_YMD").replaceAll("-", ""),
				vo.get("ENO_NO"),
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}







    /**
     * ���ó��
     * @param p_box
     * @throws CException
     */
	public void BOOK010_UPT_APP(CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� * */
	    String sql = XmlSqlUtils.getSQL("gun", "BOOK010_UPT_APP");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
	    Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("APP_YN" ))
                ,p_box.get("SESSION_ENONO")
	            ,JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
	            ,JSPUtil.rns(p_box.get("GUN_GBN"))
	            ,JSPUtil.rns(p_box.get("GUN_DPT"))
	            ,JSPUtil.rns(p_box.get("SEQ_NO" ))
	    };

	    /** INSERT�޼ҵ� ȣ�� * */
	    updateProcess(sql, bind);

	    sql = XmlSqlUtils.getSQL("gun", "BOOK010_UPT_APP2");

	    bind = new Object[] {
	    		JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
	    		,JSPUtil.rns(p_box.get("GUN_GBN"))
	    		,JSPUtil.rns(p_box.get("GUN_DPT"))
	    };

	    updateProcess(sql, bind);
	}






	public void BOOK010_UPT_HOL(CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� * */
	    String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_UPT_HOL");

	    String gun_gbn = JSPUtil.rns(p_box.get("GUN_GBN"));

		StringBuffer sb = new StringBuffer();

	    if (gun_gbn.equals("R")) {
	    	sb.append("END_TAG");
	    } else if (gun_gbn.equals("H")) {
	    	sb.append("SIGN_TAG");
	    } else if (gun_gbn.equals("J")) {
	    	sb.append("CONF_TAG");
	    }

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
	    Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("APP_YN" ))
                ,p_box.get("SESSION_ENONO")
	            ,JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
	            ,JSPUtil.rns(p_box.get("GUN_DPT"))
	    };
	    /** INSERT�޼ҵ� ȣ�� * */
	    updateProcess(sql, bind);
	}


	/**
	 * �������Խ�û �˾� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void BOOK010_SHR_11(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SHR_11");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

}
