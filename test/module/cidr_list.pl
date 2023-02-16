#============================================================================================================
#
#	携帯IPのCIDRチェック
#
#	by ぜろちゃんねるプラス
#	http://zerochplus.sourceforge.jp/
#
#============================================================================================================

package ZP_CIDR;

use strict;
use utf8;
use open IO => ':encoding(cp932)';
#use warnings;

our $cidr = ();

#------------------------------------------------------------------------------------------------------------
#
#	CIDRリスト
#	-------------------------------------------------------------------------------------
#	ただ我武者羅に資料を集めて配列化しただけ
#	どう使うかはあなた次第だ
#
#------------------------------------------------------------------------------------------------------------
{
	
	# NTT docomo : iモード [ docomo.ne.jp ]
	$cidr->{'docomo'} = [
		# http://www.nttdocomo.co.jp/service/developer/make/content/ip/
		# 2011/05更新 2013/10/12確認
		'210.153.84.0/24',		'210.136.161.0/24',		'210.153.86.0/24',		'124.146.174.0/24',
		'124.146.175.0/24',		'202.229.176.0/24',		'202.229.177.0/24',		'202.229.178.0/24',
	];
	
	# NTT docomo : iモードフルブラウザ
	$cidr->{'docomo_pc'} = [
		# http://www.nttdocomo.co.jp/service/developer/make/content/ip/
		# 2011/05更新 2013/10/12確認
		'210.153.87.0/24',
	];
	
	# NTT docomo : spモード(スマートフォン)
	$cidr->{'docomo_smart'} = [
		# http://www.nttdocomo.co.jp/service/developer/smart_phone/technical_info/etc/
		# 2013/10/12確認
		'1.66.96.0/21',			'1.66.104.0/23',		'1.72.0.0/21',			'1.72.8.0/23',
		'1.72.10.0/24',			'1.75.0.0/21',			'1.75.8.0/22',			'1.75.12.0/23',
		'1.75.14.0/24',			'1.75.16.0/20',			'1.75.152.0/21',		'1.75.224.0/19',
		'1.78.0.0/19',			'1.78.32.0/21',			'1.78.40.0/22',			'1.78.64.0/18',
		'1.79.6.0/23',			'1.79.8.0/21',			'1.79.16.0/21',			'1.79.24.0/22',
		'1.79.28.0/23',			'1.79.30.0/24',			'1.79.32.0/21',			'1.79.66.0/23',
		'1.79.68.0/22',			'1.79.72.0/21',			'1.79.80.0/20',			'1.79.96.0/21',
		'49.96.0.0/18',			'49.96.216.0/21',		'49.96.224.0/19',		'49.97.0.0/18',
		'49.97.64.0/20',		'49.97.88.0/22',		'49.97.92.0/22',		'49.97.96.0/19',
		'49.98.7.0/24',			'49.98.8.0/21',			'49.98.16.0/24',		'49.98.32.0/19',
		'49.98.64.0/18',		'49.98.128.0/17',		'110.163.6.0/23',		'110.163.8.0/22',
		'110.163.12.0/23',		'110.163.216.0/21',		'110.163.224.0/22',		'183.74.0.0/21',
		'183.74.8.0/23',		'183.75.128.0/18',
		# 2013年11月 削除予定
		'1.75.160.0/20',		'1.75.176.0/22',		'1.75.180.0/23',		'183.74.224.0/20',
		'183.74.240.0/21',		'183.74.248.0/22',
		# 2013年11月 追加予定
		'1.75.196.0/22',		'1.75.208.0/21',		'1.79.176.0/21',
		# 2013年11月 一部削除し変更予定 ※
		'183.74.192.0/19',
		# 2013年11月 追加予定 ※前行より変更
		'183.74.192.0/20',
	];
	
	# SoftBank : 3G [ softbank.ne.jp ]
	$cidr->{'vodafone'} = 
	$cidr->{'softbank'} = [
		# http://creation.mb.softbank.jp/web/web_ip.html
		# 2012/07/25更新 2013/10/12確認
		'123.108.237.112/28',	'123.108.239.224/28',	'202.253.96.144/28',	'202.253.99.144/28',
		'210.228.189.188/30',
	];
	
	# Softbank : 3G PCサイトブラウザ
	$cidr->{'vodafone_pc'} = 
	$cidr->{'softbank_pc'} = [
		# http://creation.mb.softbank.jp/web/web_ip.html
		# 2012/07/25更新 2013/10/12確認
		'123.108.237.128/28',	'123.108.239.240/28',	'202.253.96.160/28',	'202.253.99.160/28',
		'210.228.189.196/30',
	];
	
	# Softbank : スマートフォン ※3G PCサイトブラウザを含む
	$cidr->{'softbank_smart'} = [
		# https://www.support.softbankmobile.co.jp/partner/home_tech1/
		# 2013/08/09更新 2013/10/12確認
		'123.108.237.128/28',	'123.108.239.240/28',	'126.163.0.0/16',		'126.192.0.0/16',
		'126.193.0.0/16',		'126.194.208.0/22',		'126.204.0.0/16',		'202.253.96.160/28',
		'202.253.99.160/28',	'210.228.189.196/30',
		# Xシリーズ 一部アプリ
		# https://www.support.softbankmobile.co.jp/partner_st/home_tech1/X_series/index.cfm
		# 2013/05/31更新 2013/10/12確認
		'126.243.0.0/16',
	];
	
	# Softbank : iPhone/iPad 3G
	$cidr->{'softbank_iphone'} = [
		# 非公式情報 (基本放置でいきましょう 2012.06 じ)
		# panda-world.ne.jp
		# http://d.hatena.ne.jp/y-kawaz/20110427/1303870851
		# https://twitter.com/panda_watcher
		'126.95.0.0/16',		'126.140.0.0/14',		'126.144.0.0/12',		'126.160.0.0/11',
		'126.195.0.0/16',		'126.196.0.0/14',		'126.200.0.0/13',		'126.208.0.0/12',
		'126.224.0.0/11',
		# http://d.hatena.ne.jp/unstablelife/20101228/1293538861
		# http://durianjp.com/mt/2011/01/iphone-ip.html
		#'126.160.0.0/11',		'126.192.0.0/10',
	];
	
	# KDDI au : EZweb [ ezweb.ne.jp ]
	$cidr->{'ezweb'} = [
		# http://www.au.kddi.com/ezfactory/tec/spec/ezsava_ip.html
		# 2013/09/19更新 2013/10/12確認
		'210.230.128.224/28',	'219.108.158.0/27',		'219.125.146.0/28',		'61.117.2.32/29',
		'61.117.2.40/29',		'219.108.158.40/29',	'111.86.142.0/26',		'111.86.143.192/27',
		'111.86.141.64/26',		'111.86.141.128/26',	'111.86.141.192/26',	'111.86.142.160/27',
		'111.86.143.224/27',	'111.86.147.0/27',		'111.86.142.128/27',	'111.86.143.32/27',
		'111.86.142.192/27',	'111.86.142.224/27',	'111.86.143.0/27',		'111.86.147.128/27',
		'111.86.147.32/27',		'111.86.147.64/27',		'111.86.147.96/27',		'111.86.147.160/27',
		'111.86.147.192/27',	'111.86.147.224/27',	
		# 2011年秋冬モデル以降の一部機種のEZサーバ
		'111.107.116.64/26',	'106.162.214.160/29',	'111.107.116.192/28',
	];
	
	# KDDI au : EZweb PCサイトビューア
	$cidr->{'ezweb_pc'} = [
		# http://www.au.kddi.com/ezfactory/tec/spec/ezsava_ip.html
		# 2012/09/13更新 2013/10/12確認
		'222.15.68.192/26',		'59.135.39.128/27',		'118.152.214.160/27',	'118.152.214.128/27',
		'222.1.136.96/27',		'222.1.136.64/27',		'59.128.128.0/20',		'111.86.140.40/30',
		'111.86.140.44/30',		'111.86.140.48/30',		'111.86.140.52/30',		'111.86.140.56/30',
		'111.86.140.60/30',		'111.87.241.144/28',
	];
	
	# KDDI au : IS NET/LTE NET(スマートフォン)
	$cidr->{'ezweb_smart'} = [
		# http://www.au.kddi.com/developer/android/kaihatsu/network/
		# 2013/10更新 2013/10/12確認
		'106.128.0.0/13',		'111.86.140.128/27',	'182.248.112.128/26',	'182.249.0.0/16',
		'182.250.0.0/15',
		# 注) 182.249.0.0/16は以下のアドレスを除く
		#  182.249.246.1～182.249.246.3
		#  182.249.246.11～182.249.246.13
		#  182.249.246.21～182.249.246.23
		#  182.249.246.31～182.249.246.33
		#  182.249.246.97～182.249.246.126
	];
	
	# イー・モバイル [ emobile.ad.jp ]
	$cidr->{'emobile'} = [
		# http://developer.emnet.ne.jp/ipaddress.html
		# 2008/02/26更新 2013/10/12確認
		'117.55.1.224/27'
	];
	
	# WILLCOM [ prin.ne.jp ]
	$cidr->{'willcom'} = [
		# http://www.willcom-inc.com/ja/service/contents_service/create/center_info/
		# 2013/09/26更新 2013/10/12確認
		'61.198.129.0/24',		'61.198.130.0/24',		'61.198.132.0/24',		'61.198.133.0/24',
		'61.198.134.0/24',		'61.198.135.0/24',		'61.198.136.0/24',		'61.198.137.0/24',
		'61.198.139.0/29',		'61.198.139.128/27',	'61.198.139.160/28',	'61.198.142.0/24',
		'61.198.160.0/24',		'61.198.161.0/24',		'61.198.162.0/24',		'61.198.163.0/24',
		'61.198.164.0/24',		'61.198.168.0/24',		'61.198.169.0/24',		'61.198.170.0/24',
		'61.198.171.0/24',		'61.198.172.0/24',		'61.198.173.0/24',		'61.198.174.0/24',
		'61.198.175.0/24',		'61.198.248.0/24',		'61.198.249.0/24',		'61.198.250.0/24',
		'61.198.251.0/24',		'61.198.252.0/24',		'61.198.253.0/24',		'61.198.255.0/24',
		'61.204.0.0/24',		'61.204.2.0/24',		'61.204.3.128/25',		'61.204.4.0/24',
		'61.204.5.0/24',		'61.204.6.128/25',		'61.204.7.0/25',		'61.204.92.0/24',
		'61.204.93.0/24',		'61.204.94.0/24',		'61.204.95.0/24',		'114.20.49.0/24',
		'114.20.50.0/24',		'114.20.51.0/24',		'114.20.52.0/24',		'114.20.53.0/24',
		'114.20.54.0/24',		'114.20.55.0/24',		'114.20.56.0/24',		'114.20.57.0/24',
		'114.20.58.0/24',		'114.20.59.0/24',		'114.20.60.0/24',		'114.20.61.0/24',
		'114.20.62.0/24',		'114.20.63.0/24',		'114.20.64.0/24',		'114.20.65.0/24',
		'114.20.66.0/24',		'114.20.67.0/24',		'114.20.128.0/17',		'114.21.128.0/24',
		'114.21.129.0/24',		'114.21.130.0/24',		'114.21.131.0/24',		'114.21.132.0/24',
		'114.21.133.0/24',		'114.21.134.0/24',		'114.21.135.0/24',		'114.21.136.0/24',
		'114.21.137.0/24',		'114.21.138.0/24',		'114.21.139.0/24',		'114.21.140.0/24',
		'114.21.141.0/24',		'114.21.142.0/24',		'114.21.143.0/24',		'114.21.144.0/24',
		'114.21.145.0/24',		'114.21.146.0/24',		'114.21.147.0/24',		'114.21.148.0/24',
		'114.21.149.0/24',		'125.28.0.0/24',		'125.28.1.0/24',		'125.28.2.0/24',
		'125.28.3.0/24',		'125.28.6.0/24',		'125.28.7.0/24',		'125.28.8.0/24',
		'125.28.11.0/24',		'125.28.12.0/24',		'125.28.13.0/24',		'125.28.14.0/24',
		'125.28.15.0/24',		'125.28.16.0/24',		'125.28.17.0/24',		'210.168.246.0/24',
		'210.168.247.0/24',		'210.169.92.0/24',		'210.169.93.0/24',		'210.169.95.0/24',
		'210.169.96.0/24',		'210.169.97.0/24',		'210.169.98.0/24',		'210.169.99.0/24',
		'210.255.190.0/24',		'211.126.192.128/25',	'211.18.232.0/24',		'211.18.233.0/24',
		'211.18.234.0/24',		'211.18.235.0/24',		'211.18.236.0/24',		'211.18.237.0/24',
		'211.18.238.0/24',		'211.18.239.0/24',		'219.108.2.0/24',		'219.108.3.0/24',
		'219.108.4.0/24',		'219.108.5.0/24',		'219.108.6.0/24',		'219.108.7.0/24',
		'219.108.10.0/24',		'219.108.11.0/24',		'219.108.12.0/24',		'219.108.13.0/24',
		'219.108.14.0/24',		'219.108.15.0/24',		'221.109.128.0/18',		'221.119.0.0/24',
		'221.119.1.0/24',		'221.119.2.0/24',		'221.119.3.0/24',		'221.119.4.0/24',
		'221.119.5.0/24',		'221.119.6.0/24',		'221.119.7.0/24',		'221.119.8.0/24',
		'221.119.9.0/24',
	];
	
	# ibisブラウザ
	$cidr->{'ibis'} = [
		# http://ibis.ne.jp/support/browserIP.jsp
		# 2013/10/12確認
		'54.248.5.162/32',		'54.248.145.37/32',		'54.248.147.159/32',	'54.248.148.218/32',
		'54.248.150.59/32',		'54.248.153.81/32',		'54.248.160.163/32',	'54.248.164.51/32',
		'54.248.165.159/32',	'54.248.173.87/32',		'54.248.176.184/32',	'54.248.178.251/32',
		'54.248.181.37/32',		'54.248.184.172/32',	'54.248.187.26/32',		'54.248.226.234/32',
		'54.248.229.21/32',		'54.248.233.80/32',		'175.41.198.11/32',		'176.34.14.9/32',
	];
	
	# jigブラウザ
	$cidr->{'jig'} = [
		# http://br.jig.jp/pc/ip_br.html
		# 2013/07/31更新 2013/10/12確認
		'112.78.114.208/32',	'112.78.207.6/31',		'112.78.207.8/29',		'112.78.207.16/29',
		'112.78.207.24/31',		'112.78.215.70/31',		'112.78.215.72/29',		'112.78.215.80/29',
		'112.78.215.88/31',		'112.78.215.166/31',	'112.78.215.168/29',	'112.78.215.176/29',
		'112.78.215.184/31',	'112.78.215.230/31',	'112.78.215.232/29',	'112.78.215.240/29',
		'112.78.215.248/31',	'182.48.5.230/31',		'182.48.5.232/29',		'202.181.98.160/32',
		'202.181.98.179/32',	'202.181.98.196/32',	'210.188.205.81/32',	'210.188.205.83/32',
		'219.94.177.6/31',		'219.94.177.8/29',		'219.94.177.16/29',		'219.94.177.24/31',
		'219.94.182.230/31',	'219.94.182.232/29',	'219.94.182.240/29',	'219.94.182.248/31',
		'219.94.183.102/31',	'219.94.183.104/29',	'219.94.183.112/29',	'219.94.183.120/31',
		'219.94.184.70/31',		'219.94.184.72/29',
	];
	
	$cidr->{'iphone'} = [(
		@{$cidr->{'softbank_iphone'}},
	)];
	# uqwimax.jp
	
	# p2
	$cidr->{'p2'} = [
		# cw43.razil.jp
		'210.135.98.43',
		# p202.razil.jp
		'210.135.100.132',
	];
}

1;
