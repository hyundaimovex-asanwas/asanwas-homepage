package common.groupware;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gauce.GauceDataSet;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.support.collection.CBox;

import common.util.JSPUtil;

import java.io.*;
import com.shift.gef.core.log.Log;
/**
 * GroupWare요청사항을 가우스를 통하지 않고 서버로 전송 처리하는 프로그램
 * @author 권혁수
 * @version 1.0, 2009.12.02
 * @see
 */
public class DiligenceServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException ,IOException {
		try
		{
			/*
			 * 회계부서코드에 있는 EXT_03의 근태등록시간을 가지고 check
			 */

			String ENO_NO = req.getParameter("ENO_NO").substring(3);

			DiligenceDAO dao = new DiligenceDAO("default");

			CBox p_box = new CBox();
			p_box.put("ENO_NO", ENO_NO);

			// 직원여부 체크
			GauceDataSet ds = dao.GROUPWARE_SHR_03(p_box);
			int rowCnt = ds.getDataRowCnt();
			//System.out.println("그룹웨어 근태 직원여부 rowCnt [" + rowCnt + "]");
			System.out.print(" \n그룹웨어 근태 사원번호 [" + ENO_NO + "]");
			if(rowCnt > 0){

				String EXT_03 = JSPUtil.rns(GauceUtils.nameValue(ds, 1, "EXT_03"));
				String GUN_CD = GauceUtils.nameValue(ds, 1, "GUN_CD");
				String CUR_DATE = GauceUtils.nameValue(ds, 1, "CUR_DATE");
				String DPT_CD = GauceUtils.nameValue(ds, 1, "DPT_CD");
				String GUN_YMD = GauceUtils.nameValue(ds, 1, "GUN_YMD");
				String C_YMDHM = GauceUtils.nameValue(ds, 1, "C_YMDHM");
				String S_YMDHM = GauceUtils.nameValue(ds, 1, "S_YMDHM");

				System.out.print(" / 그룹웨어 근태일   [" + GUN_YMD + "]");
				System.out.print(" / 그룹웨어 현재시간 [" + CUR_DATE + "]");
				//System.out.println("그룹웨어 근태시간 [" + EXT_03 + "]");
				//System.out.println("그룹웨어 미획인근태시간 [" + S_YMDHM + "]");
				//System.out.println("그룹웨어 지각근태시간   [" + C_YMDHM + "]");
				//System.out.println("그룹웨어 근태부서 [" + DPT_CD + "]");
				System.out.println(" / 그룹웨어 근태코드 [" + GUN_CD + "]");
				if("".equals(EXT_03)){
					System.out.print(" / 회계부서코드에 근태시간이 적혀있지 않습니다");
					return;
				}
				// T_DI_DILIGENCE 에 값이 없을때 값 새로 작성
				dao.GROUPWARE_INS_01(p_box, GUN_YMD, DPT_CD);
				// 이전휴일에 Y 값 세팅
				dao.GROUPWARE_UPT_01(GUN_YMD, p_box);
				// T_DI_DILIGENCE에 근태코드값 수정
				dao.GROUPWARE_UPT_01(GUN_YMD, ENO_NO, GUN_CD, p_box);
				// T_DI_DILIGENCE에 근태총계값 수정
				dao.GROUPWARE_UPT_02(GUN_YMD, ENO_NO, p_box);
			}else{

			}

		} catch (Exception e) {
			System.out.println("DiligenceServlet ........ Error !!");
			e.printStackTrace();
		}
	}
    public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException {

		doGet(req,res);
   }
}
