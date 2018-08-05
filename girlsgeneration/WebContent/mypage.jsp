<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_html_header.jsp" %>
<%
if (userId == null) {
	out.println("<script>");
	out.println("location.replace('login_form.jsp');");
	out.println("</script>");
}

String email = "";
String level = "";



try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	
	String sql = "select m_email, m_level from member where m_id = '" + userId + "';";

	rs = stmt.executeQuery(sql);
	
	
	if (rs.next()) {
		email = rs.getString("m_email");
		level = rs.getString("m_level");
		if (level.equals("N")) level = "일반회원";
		else if (level.equals("S")) level = "실버회원";
		else if (level.equals("G")) level = "골드회원";
		else if (level.equals("V")) level = "VIP회원";
		else if (level.equals("M")) level = "마스터회원";
	}
} catch(Exception e) {
	out.println("<h3>DB작업에 실패하였습니다.</h3>");
	e.printStackTrace();
} finally {
	// 사용된 객체 닫기
	try {
		rs.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=userName %>의 마이페이지</title>
<style>

#div_mypage {
	position:relative;
	width:1150px;
	margin:50px auto 150px auto;
	border:1px solid black;
}

.faq_box {
	float:left;
	padding:0 1px 0 0;
	margin-bottom:-3px;
}

.faq_box img{
	width:229px;
}

#mypage_mebmer{
	position:relative;
	width:1150px;
	height:150px;
	margin-top:67px;
}

	
#mypage_member_Info{
	float:left;
	margin-top:30px;
	margin-left:50px;
	padding:10px;
	width:300px;
	border:2px #FFA5C3 solid;
	font-size:large;
	

}

#mapage_member_score{
	float:right;
	margin-top:30px;
	margin-right:100px;
	padding:10px;
	padding-bottom:30px;
	border:2px #FFA5C3 solid;
	width:300px;
	font-size:large;

}

.banner{
	border:1px solid red;
	align-content:center;
	
	
}
#mypage_table td {text-align:center;}
#mypage_table th { text-align:center; font-weight:bold; }



#mypage_return{
	display:none;
}
#mypage_point{
	display:none;
}
#mypage_Infomation{
	display:none;
}
#mypage_delivery{
	display:none;
}


</style>
<script>

function change_banner(type){
	var mypage_order = document.getElementById("mypage_order");
	var button1 = document.getElementById("banner_button_1");

    var mypage_return = document.getElementById("mypage_return");
    var button2 = document.getElementById("banner_button_2");


    var mypage_point = document.getElementById("mypage_point");
    var button3 = document.getElementById("banner_button_3");


    var mypage_Infomation = document.getElementById("mypage_Infomation");
    var button4 = document.getElementById("banner_button_4");


    var mypage_delivery = document.getElementById("mypage_delivery");
    var button5 = document.getElementById("banner_button_5");

    
    
    if (mypage_order == null)
    {
    	mypage_order.style.display = "block";
    	
    }
    else
    {
    	if (type == 1)
        {
    		mypage_order.style.display = "block";
            button1.src = "images/mypage_on1.png";
            
            mypage_return.style.display = "none";
            button2.src = "images/mypage_off2.png";
            
            mypage_point.style.display = "none";
            button3.src = "images/mypage_off3.png";
            
            mypage_Infomation.style.display = "none";
            button4.src = "images/mypage_off4.png";
            
            mypage_delivery.style.display = "none";
            button5.src = "images/mypage_off5.png";

        }

        else if (type == 2)
        {
        	mypage_order.style.display = "none";
            button1.src = "images/mypage_off1.png";

            mypage_return.style.display = "block";
            button2.src = "images/mypage_on2.png";
	
            mypage_point.style.display = "none";
            button3.src = "images/mypage_off3.png";
	
            mypage_Infomation.style.display = "none";
            button4.src = "images/mypage_off4.png";
	
            mypage_delivery.style.display = "none";
            button5.src = "images/mypage_off5.png";
	
    }
        else if (type == 3)
        {
        	mypage_order.style.display = "none";
            button1.src = "images/mypage_off1.png";

            mypage_return.style.display = "none";
            button2.src = "images/mypage_off2.png";
	
            mypage_point.style.display = "block";
            button3.src = "images/mypage_on3.png";
	
            mypage_Infomation.style.display = "none";
            button4.src = "images/mypage_off4.png";
	
            mypage_delivery.style.display = "none";
            button5.src = "images/mypage_off5.png";

	
    }
        else if (type == 4)
        {
        	mypage_order.style.display = "none";
            button1.src = "images/mypage_off1.png";

            mypage_return.style.display = "none";
            button2.src = "images/mypage_off2.png";
	
            mypage_point.style.display = "none";
            button3.src = "images/mypage_off3.png";
	
            mypage_Infomation.style.display = "block";
            button4.src = "images/mypage_on4.png";
	
            mypage_delivery.style.display = "none";
            button5.src = "images/mypage_off5.png";

    }
        else if (type == 5)
        {
        	mypage_order.style.display = "none";
            button1.src = "images/mypage_off1.png";

            mypage_return.style.display = "none";
            button2.src = "images/mypage_off2.png";
	
            mypage_point.style.display = "none";
            button3.src = "images/mypage_off3.png";
	
            mypage_Infomation.style.display = "none";
            button4.src = "images/mypage_off4.png";
	
            mypage_delivery.style.display = "block";
            button5.src = "images/mypage_on5.png";
		}
        else{
			return;
        }
    }
}




</script>
</head>
<body>
<div id="div_mypage">
<!--b-->
<div class=faq_box><a href='javascript:change_banner(1);'>
	<img id='banner_button_1' src='images/mypage_on1.png' alt='주문배송현황' border=0></a>
	</div>

<div class=faq_box><a href='javascript:change_banner(2);'>
<img id='banner_button_2' src='images/mypage_off2.png'  alt='반품 교환' border=0></a></div>

<div class=faq_box><a href='javascript:change_banner(3);'>
<img id='banner_button_3' src='images/mypage_off3.png' alt='적립금' border=0></a></div>

<div class=faq_box><a href='javascript:change_banner(4);'>
<img id='banner_button_4' src='images/mypage_off4.png' alt='개인정보수정/탈퇴' border=0></a></div>

<div class=faq_box><a href='javascript:change_banner(5);'>
<img id='banner_button_5' src='images/mypage_off5.png' alt='배송지' border=0></a></div>
	
<div id="mypage_mebmer">
	<div id="mypage_member_Info">
		<%=userName %>님 환영합니다.<br />
		아이디 : <%=userId %><br />
		이메일 : <%=email %>
	</div>

	<div id="mapage_member_score">
		고객님의 회원 등급은 [<%=level %>]입니다.<br />
		<a href="membership.jsp"><strong style="color:blue;">자세한 혜택 보기</strong></a>
	</div>
</div>



<div id="mypage_order" class="banner">
	<jsp:include page="mypage_order.jsp" />

</div>

<div id="mypage_return" class="banner">
	<jsp:include page="mypage_return.jsp" />
</div>

<div id="mypage_point" class="banner">
	<jsp:include page="mypage_point.jsp" />
</div>


<div id="mypage_Infomation" class="banner">
	<jsp:include page="mypage_Infomation.jsp" />
</div>

<div id="mypage_delivery" class="banner">
	<jsp:include page="mypage_delivery.jsp" />
</div>

</div>	
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>