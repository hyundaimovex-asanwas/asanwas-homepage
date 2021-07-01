/*******************************************************************************
 * 1.클래스   명 : EncodingFilter.java
 * 2.클래스 개요 :
 * 3.관련 테이블 :
 * 4.관련 클래스 :
 * 5.관련 페이지 :
 * 6.작   성  자 : 이태선
 * 7.작 성 일 자 : 2004-03-30
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
 * . 2004-03-24      ;
 * @author 이태선
 * @version 1.0 2006-02-02
 ******************************************************************************/

package sales.org.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * <pre>
 * Servlet 2.3 이상인 경우 web.xml 파일에 EncodingFilter 클래스를
 * 등록하면 ServletRequest 객체에 전달되는 값의 기본 인코딩값을
 * 설정할 수 있다.
 * web.xml 설정 방법은 다음과 같다.
 * &lt;filter&gt;
 *  &lt;filter-name&gt;Encoding Filter&lt;/filter-name&gt;
 *     &lt;display-name&gt;Encoding Filter&lt;/display-name&gt;
 *     &lt;filter-class&gt;com.ktf.cass.util.EncodingFilter&lt;/filter-class&gt;
 *     &lt;init-param&gt;
 *        &lt;param-name&gt;encoding&lt;/param-name&gt;
 *        &lt;param-value&gt;EUC-KR&lt;/param-value&gt;
 *     &lt;/init-param&gt;
 *  &lt;/filter&gt;

 *  &lt;filter-mapping&gt;
 *     &lt;filter-name&gt;Encoding Filter&lt;/filter-name&gt;
 *     &lt;url-pattern&gt;/*&lt;/url-pattern&gt;
 *  &lt;/filter-mapping&gt;
 *   
 * </pre>
 */
public class EncodingFilter implements Filter {
	
	private String encoding = null;
	
	/**
	 * 필터 정보 객체를 나타낸다.
	 */
	protected FilterConfig filterConfig = null;
	
	/**
	 * EncodingFilter 객체를 소멸시키며, 변수값들을 초기화 한다.	 
	 * @return void
	 */
	public void destroy() {

		this.encoding = null;
		this.filterConfig = null;

	}
	/**
	 * ServletRequest객체에 web.xml에서 전달된 인코딩을 설정한다.
	 * @param request 서비스를 요청하는 객체.
	 * @param response 요청에 답하는 객체. 
	 * @param chain 인코딩을 하는 객체.
	 * @return void
	 */
	public void doFilter(
		ServletRequest request,
		ServletResponse response,
		FilterChain chain)
		throws IOException, ServletException {

		if (request.getCharacterEncoding() == null) {
			if (encoding != null) {
				request.setCharacterEncoding(encoding);
			}
		}
		chain.doFilter(request, response);
		
	}

	/**
	 * web.xml에서 전달된 인코딩 값을 초기화한다.
	 * @param filterConfig 인코딩 초기화 값들을 가지고 있는 객체.
	 * @return void
	 */
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		this.encoding = filterConfig.getInitParameter("encoding");
	}
	/**
	 * 필터 설정에 관한 환경값을 가져온다.
	 * @return FilterConfig 
	 */
	public FilterConfig getFilterConfig() {
		return filterConfig;
	}
	/**
	 * 필터 환경을 설정한다.
	 * @param cfg 인코딩을 위한 값들을 가지고 있는 객체.
	 * @return void
	 */
	public void setFilterConfig(FilterConfig cfg) {
		filterConfig = cfg;
	}
}
