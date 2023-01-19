#============================================================================================================
#
#	フォーム情報管理モジュール
#
#============================================================================================================
package	FORM;

use strict;
use utf8;
binmode(STDOUT,":utf8");
#use warnings;

#------------------------------------------------------------------------------------------------------------
#
#	モジュールコンストラクタ - new
#	-------------------------------------------
#	引　数：$throughget	GETリクエストの受け入れ
#	戻り値：モジュールオブジェクト
#
#------------------------------------------------------------------------------------------------------------
sub new
{
	my $class = shift;
	my ($throughget) = @_;
	
	my $form = '';
	if ($ENV{'REQUEST_METHOD'} eq 'POST') {
		read STDIN, $form, $ENV{'CONTENT_LENGTH'};
	}
	elsif ($throughget && defined $ENV{'QUERY_STRING'}) {
		$form = $ENV{'QUERY_STRING'};
	}
	
	my @SRC = split(/[&;]/, $form);
	
	my $obj = {
		'FORM'	=> undef,
		'SRC'	=> \@SRC,
	};
	
	bless $obj, $class;
	
	return $obj;
}

#------------------------------------------------------------------------------------------------------------
#
#	フォーム情報デコード - DecodeForm
#	-------------------------------------------
#	引　数：$mode : 
#	戻り値：なし
#
#------------------------------------------------------------------------------------------------------------
sub DecodeForm
{
	my $this = shift;
	my ($mode) = @_;
	
	$this->{'FORM'} = {};
	
	foreach (@{$this->{'SRC'}}) {
		my ($var, $val) = split(/=/, $_, 2);
		$val =~ tr/+/ /;
		$val =~ s/%([0-9a-fA-F][0-9a-fA-F])/pack('C', hex($1))/eg;
		$val =~ s/\r\n|\r|\n/\n/g;
		$val =~ s/\0//g;
		$this->{'FORM'}->{$var} = $val;
		$this->{'FORM'}->{"Raw_$var"} = $val;
	}
}

#------------------------------------------------------------------------------------------------------------
#
#	特定フォーム情報デコード - GetAtArray
#	-------------------------------------------
#	引　数：$key : 取得キー
#			$f   : 変換フラグ
#	戻り値：キーデータの配列
#
#------------------------------------------------------------------------------------------------------------
sub GetAtArray
{
	my $this = shift;
	my ($key, $f) = @_;
	
	my @ret = ();
	
	foreach (@{$this->{'SRC'}}) {
		my ($var, $val) = split(/=/, $_, 2);
		if ($key eq $var) {
			$val =~ tr/+/ /;
			$val =~ s/%([0-9a-fA-F][0-9a-fA-F])/pack('C', hex($1))/eg;
			$val =~ s/\r\n|\r|\n/\n/g;
			$val =~ s/\0//g;
			if ($f) {
				$val =~ s/"/&quot;/g;
				$val =~ s/</&lt;/g;
				$val =~ s/>/&gt;/g;
				$val =~ s/\r\n|\r|\n/<br>/g;
			}
			push @ret, $val;
		}
	}
	return @ret;
}

#------------------------------------------------------------------------------------------------------------
#
#	フォーム情報取得 - Get
#	-------------------------------------------
#	引　数：$key : 取得キー
#			$default : デフォルト
#	戻り値：データ
#
#------------------------------------------------------------------------------------------------------------
sub Get
{
	my $this = shift;
	my ($key, $default) = @_;
	
	my $val = $this->{'FORM'}->{$key};
	
	return (defined $val ? $val : (defined $default ? $default : ''));
}

#------------------------------------------------------------------------------------------------------------
#
#	フォーム情報設定 - Set
#	-------------------------------------------
#	引　数：$key  : 取得キー
#			$data : 設定データ
#	戻り値：なし
#
#------------------------------------------------------------------------------------------------------------
sub Set
{
	my $this = shift;
	my ($key, $data) = @_;
	
	$this->{'FORM'}->{$key} = $data;
}

#------------------------------------------------------------------------------------------------------------
#
#	form値存在確認
#	-------------------------------------------------------------------------------------
#	@param	$key	キー
#	@param	$data	値
#	@return	値が等しいならtrueを返す
#
#------------------------------------------------------------------------------------------------------------
sub Equal
{
	my $this = shift;
	my ($key, $data) = @_;
	
	my $val = $this->{'FORM'}->{$key};
	
	return (defined $val && $val eq $data);
}

#------------------------------------------------------------------------------------------------------------
#
#	入力チェック - IsInput
#	-------------------------------------------
#	引　数：$pkeylist : 判定項目リスト(リファレンス)
#	戻り値：入力OKなら1,未入力ありなら0
#
#------------------------------------------------------------------------------------------------------------
sub IsInput
{
	my $this = shift;
	my ($pKeyList) = @_;
	
	foreach (@$pKeyList) {
		my $val = $this->{'FORM'}->{$_};
		if (!defined $val || $val eq '') {
			return 0;
		}
	}
	return 1;
}

#------------------------------------------------------------------------------------------------------------
#
#	全入力チェック - IsInput
#	-------------------------------------------
#	引　数：なし
#	戻り値：入力OKなら1,未入力ありなら0
#
#------------------------------------------------------------------------------------------------------------
sub IsInputAll
{
	my $this = shift;
	
	foreach (values %{$this->{'FORM'}}) {
		if ($_ eq '') {
			return 0;
		}
	}
	return 1;
}

#------------------------------------------------------------------------------------------------------------
#
#	form値存在確認
#	-------------------------------------------------------------------------------------
#	@param	$key	キー
#	@return	キーが存在したらtrue
#
#------------------------------------------------------------------------------------------------------------
sub IsExist
{
	my $this = shift;
	my ($key) = @_;
	
	return exists $this->{'FORM'}->{$key};
}

#------------------------------------------------------------------------------------------------------------
#
#	form値存在確認
#	-------------------------------------------------------------------------------------
#	@param	$key	キー
#	@param	$string	検索文字
#	@return	検索文字が存在したら1
#
#------------------------------------------------------------------------------------------------------------
sub Contain
{
	my $this = shift;
	my ($key, $string) = @_;
	
	if ($this->{'FORM'}->{$key} =~ /\Q$string\E/) {
		return 1;
	}
	return 0;
}

#------------------------------------------------------------------------------------------------------------
#
#	列挙form値取得
#	-------------------------------------------------------------------------------------
#	@param	$pArray	結果格納バッファ
#	@param	@list	取得データリスト
#	@return	なし
#
#------------------------------------------------------------------------------------------------------------
sub GetListData
{
	my $this = shift;
	my ($pArray, @list) = @_;
	
	foreach (@list) {
		push @$pArray, $this->{'FORM'}->{$_};
	}
}

#------------------------------------------------------------------------------------------------------------
#
#	数字調査
#	-------------------------------------------------------------------------------------
#	@param	$pKeys	調査データキー
#	@return	数字なら1
#
#------------------------------------------------------------------------------------------------------------
sub IsNumber
{
	my $this = shift;
	my ($pKeys) = @_;
	
	foreach (@$pKeys) {
		if ($this->{'FORM'}->{$_} =~ /[^0-9]/) {
			return 0;
		}
	}
	return 1;
}

#------------------------------------------------------------------------------------------------------------
#
#	半角英数字調査
#	-------------------------------------------------------------------------------------
#	@param	$pKeys	調査データキー
#	@return	半角英数字なら1
#
#------------------------------------------------------------------------------------------------------------
sub IsAlphabet
{
	my $this = shift;
	my ($pKeys) = @_;
	
	foreach (@$pKeys) {
		if ($this->{'FORM'}->{$_} =~ /[^0-9a-zA-Z_@]/) {
			return 0;
		}
	}
	return 1;
}

#------------------------------------------------------------------------------------------------------------
#
#	キャップキー用文字列調査
#	-------------------------------------------------------------------------------------
#	@param	$pKeys	調査データキー
#	@return	半角英数字なら1
#
#------------------------------------------------------------------------------------------------------------
sub IsCapKey
{
	my $this = shift;
	my ($pKeys) = @_;
	
	foreach (@$pKeys) {
		if ($this->{'FORM'}->{$_} =~ /[^0-9a-zA-Z\_\.\+\-\*\/\@\:\!\%\&\(\)\=\~\^]/) {
			return 0;
		}
	}
	return 1;
}

#------------------------------------------------------------------------------------------------------------
#
#	掲示板ディレクトリ名用文字列調査
#	-------------------------------------------------------------------------------------
#	@param	$pKeys	調査データキー
#	@return	半角英数字なら1
#
#------------------------------------------------------------------------------------------------------------
sub IsBBSDir
{
	my $this = shift;
	my ($pKeys) = @_;
	
	foreach (@$pKeys) {
		if ($this->{'FORM'}->{$_} =~ /[^0-9a-zA-Z\_\-]/) {
			return 0;
		}
	}
	return 1;
}

#============================================================================================================
#	モジュール終端
#============================================================================================================
1;
