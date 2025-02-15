#include <stdlib.h>
#include "lidar.h"
#include "bsp_uart.h"
#include "check.h"
  
T_LIDARSCANINFO lidarscaninfo;
/********************************************************************************************/
//初始化雷达扫描信息函数
//参数:     无
//返回值:   无
/*****************************************************************************************/
void Lidarscaninfo_Init(void)
{
	lidarscaninfo.State = GRAB_SCAN_FIRST;
	lidarscaninfo.ToothCount=0;
	lidarscaninfo.LastScanAngle=0.0;
	lidarscaninfo.Result = LIDAR_GRAB_ING;
	lidarscaninfo.OneCriclePointNum=0;
}

uint16_t Little2BigEndian_u16(uint16_t dat)
{
	return ((dat>>8)|(dat<<8));
}
uint16_t Big2LittleEndian_u16(uint16_t dat)
{
	return ((dat>>8)|(dat<<8));
}
/********************************************************************************************/
//2个字符转换成uint16_t函数
//参数:     无
//返回值:   无
/*****************************************************************************************/
uint16_t Strto_u16(uint8_t* str)
{
	return ((*str << 8) | *(str+1));
}
uint16_t LittleStrto_u16(uint8_t* str)
{
	return (*str | (*(str+1)<<8));
}

void LittleCopy_u16(uint8_t *dest,uint8_t *src,uint16_t len)
{
	while(len)
  {
		*dest = *(src+1);
		*(dest+1) = *src;
		dest+=2;src+=2;
		len--;
	}
}
/********************************************************************************************/
//一次测量点信息插入到一圈点信息的数据结构中 函数
//参数:     无
//返回值:   无
/*****************************************************************************************/
void OneCriclePoint_insert(T_FRAME_MEAS_INFO *one_meas_info)
{
	uint8_t i=0;
	for(i=0;i<one_meas_info->PointNum;i++)
	{
		lidarscaninfo.OneCriclePoint[lidarscaninfo.OneCriclePointNum].Angle=one_meas_info->Point[i].Angle;
		lidarscaninfo.OneCriclePoint[lidarscaninfo.OneCriclePointNum].Distance=one_meas_info->Point[i].Distance;
		lidarscaninfo.OneCriclePointNum++;
	}
}
/********************************************************************************************/
//判断是不是扫描到第一个齿轮 函数
//参数:     无
//返回值:   无
/*****************************************************************************************/
uint8_t isFirstGratingScan(float angle)
{
	return (angle >= 35900 || angle <= 2250);
}
/********************************************************************************************/
//存储第一个齿轮间扫描的点数 函数
//参数:     无
//返回值:   无
/*****************************************************************************************/
void grabFirstGratingScan(T_FRAME_MEAS_INFO *one_meas_info)
{
	lidarscaninfo.State = GRAB_SCAN_ELSE_DATA;
	lidarscaninfo.ToothCount=1;
	lidarscaninfo.LastScanAngle=one_meas_info->FrameEndAngle;
	OneCriclePoint_insert(one_meas_info);
}
/********************************************************************************************/
//扫描一圈的过程 函数
//参数:     无
//返回值:   无
/*****************************************************************************************/
void ScanOneCircle(T_FRAME_MEAS_INFO *one_meas_info)
{
	switch(lidarscaninfo.State)
	{
		case GRAB_SCAN_FIRST:
				//first tooth scan come
				if(isFirstGratingScan(one_meas_info->FrameStartAngle))
				{
					Lidarscaninfo_Init();
					grabFirstGratingScan(one_meas_info);
				}
				else
				{
					//printf("[Lidar] GRAB_SCAN_FIRST is not zero; scan angle %5.2f!\n",one_meas_info.FrameStartAngle);
				}
				break;
		
		case GRAB_SCAN_ELSE_DATA:
				/* Handle angle suddenly reduces */
				if(one_meas_info->FrameStartAngle < lidarscaninfo.LastScanAngle) 
				{    
					return;
						//printf("[Lidar] Restart scan, FrameStartAngle: %5.2f, LastScanAngle: %5.2f!\n",one_meas_info.FrameStartAngle, lidarscaninfo.LastScanAngle); 
						//这次角度小于上一次角度，且角度为零：表示这一圈数据不完整，刚好从零点重新下一圈(这圈数据丢掉)
						if(isFirstGratingScan(one_meas_info->FrameStartAngle))
						{
							Lidarscaninfo_Init();
							grabFirstGratingScan(one_meas_info);
						}
						else //这次角度小于上一次角度，且角度不为零：表示这一圈和下圈数据都不完整，重新矫正到零点开始扫描，这一圈和下圈数据都丢掉
						{
							lidarscaninfo.State = GRAB_SCAN_FIRST;
						}
						return;				
        }
				OneCriclePoint_insert(one_meas_info);
				lidarscaninfo.ToothCount++;
				lidarscaninfo.LastScanAngle = one_meas_info->FrameEndAngle;

				if(lidarscaninfo.ToothCount == TOOTH_NUM)//Scan One Circle
				{
					lidarscaninfo.ToothCount=0;
					lidarscaninfo.State = GRAB_SCAN_FIRST;
					lidarscaninfo.Result =  LIDAR_GRAB_SUCESS;
					return;
				}
				break;			
		default:
				printf("[Lidar] Uknow grab scan data state\n");
				break;
	}
	lidarscaninfo.LastScanAngle = one_meas_info->FrameEndAngle;
}
/********************************************************************************************/
//上报扫描距离信息帧解析函数
//参数:     无
//返回值:   无
/*****************************************************************************************/
void AnalysisMeasureInfo(T_PROTOCOL Preq)
{
	uint8_t data_head_offset=0;
	uint8_t i = 0;
	float per_angle_offset = 0;

	lidarscaninfo.FrameMeasInfo.RotaSpeed = *(Preq.Data+data_head_offset)*0.05f;
	data_head_offset +=1;  
    lidarscaninfo.FrameMeasInfo.ZeroOffset = Strto_u16(Preq.Data+data_head_offset)*0.01f;
	data_head_offset +=2;
	//lidarscaninfo.FrameMeasInfo.FrameStartAngle = Strto_u16(Preq.Data+data_head_offset)*0.01f;
	lidarscaninfo.FrameMeasInfo.FrameStartAngle = Strto_u16(Preq.Data+data_head_offset);
	data_head_offset +=2; 
    //lidarscaninfo.FrameMeasInfo.FrameEndAngle = Strto_u16(Preq.Data+data_head_offset)*0.01f;
    lidarscaninfo.FrameMeasInfo.FrameEndAngle = Strto_u16(Preq.Data+data_head_offset);
	data_head_offset +=2;
	
	Preq.ParamLen = (Preq.ParamLen >> 8) | ((Preq.ParamLen << 8) & 0xFF);
	lidarscaninfo.FrameMeasInfo.PointNum = (Preq.ParamLen-7)/3;
	
	per_angle_offset=(lidarscaninfo.FrameMeasInfo.FrameEndAngle - lidarscaninfo.FrameMeasInfo.FrameStartAngle)/(lidarscaninfo.FrameMeasInfo.PointNum - 1);
	for(i=0;i<lidarscaninfo.FrameMeasInfo.PointNum;i++)
	{
		lidarscaninfo.FrameMeasInfo.Point[i].Distance = Strto_u16(Preq.Data+data_head_offset+3*i)*0.25;
        
		lidarscaninfo.FrameMeasInfo.Point[i].Angle=(lidarscaninfo.FrameMeasInfo.FrameStartAngle+i*per_angle_offset)*0.01;
	}
	
	ScanOneCircle(&(lidarscaninfo.FrameMeasInfo));
}
/********************************************************************************************/
//设置雷达工作模式应答帧 解析函数
//参数:     无
//返回值:   无
/*****************************************************************************************/
void AnalysisSetWorkMode(T_PROTOCOL Preq)
{
	//switch()
}
/********************************************************************************************/
//设置雷达工作模式应答帧 解析函数
//参数:     无
//返回值:   无
/*****************************************************************************************/
void AnalysisAdjRotaSpeed(T_PROTOCOL Preq)
{

}

/********************************************************************************************/
//上报设备故障信息帧 解析函数
//参数:     无
//返回值:   无
/*****************************************************************************************/
void AnalysisReportDevErrInfo(T_PROTOCOL Preq)
{
//	float speed = 0;
//	speed = *(Preq.Data)*0.05f;
	printf("[Lidar] Device error!\r\n");
}
/********************************************************************************************/
//判断通讯帧是否完整帧函数
//参数:     无
//返回值:   无
/*****************************************************************************************/
uint8_t FrameIsRight(T_PROTOCOL Preq)
{
	uint16_t Temp = 0,CalcCRC,Len;
	uint8_t i;
	//Len = Preq.Len;
	Len = Preq.Len >> 8 | Preq.Len << 8;
	if(Preq.Header != 0xAA)
	{	
		printf("e  h\r\n");
		return 0;
	}
	else if(Len > RxBuffer.Len)
	{
		//printf("e l\r\n");
		return 0;
	}
	else if(Preq.ProtoVer != PROTO_VER && Preq.ProtoVer != 0x01 && Preq.ProtoVer != 0x11)
	{
		//printf("e p\r\n");
		return 0;
	} 
    else if(Preq.FrmType != FRAME_TYPE)
    {
			//printf("e t\r\n");
        return 0;
    }
	else 
	{	
		//1.crc校验
		//CalcCRC = CRC16(RxBuffer.Buff,Len);
		//2.累加校验和
		CalcCRC	= Calc_CheckSum(RxBuffer.Buff,Len);
		
		LittleCopy_u16((uint8_t *)&Temp,&RxBuffer.Buff[Len],1);
		//Temp=Big2LittleEndian_u16(Temp);
		//Temp = Temp >> 8 | Temp << 8; 
		if(CalcCRC != Temp)
		{
			printf("[Lidar] Frame is CRC error!\n");
			return 0;
		}
	}
	return 1;
}
/********************************************************************************************/
//通讯帧解析函数
//参数:     无
//返回值:   无
/*****************************************************************************************/
void FrameAnalysis(T_PROTOCOL Preq)
{
	uint8_t cmdid = Preq.CmdId;
	switch(cmdid) 
	{
		case CMD_REPORT_SCAN_INFO:
			AnalysisMeasureInfo(Preq);
		break;
		case CMD_REPORT_DEV_ERR_INFO:
			AnalysisReportDevErrInfo(Preq);
		break;
		default:
			printf("[Lidar] Preq.CmdId is wrong!\n");
		break;;
	}
}

/********************************************************************************************/
//通讯帧处理函数
//参数:     无
//返回值:   无
/*****************************************************************************************/
uint8_t P_Cmd_Process(void)
{
	int i = 0;
	int j;
  T_PROTOCOL Preq;
	
	memcpy((uint8_t *)&Preq,(uint8_t * )RxBuffer.Buff,8);
	Preq.Data = &RxBuffer.Buff[8];
	
	if(FrameIsRight(Preq)==0)
	{
		//printf("error\r\n");
		return 0;
	}
	//printf("pp\r\n");
	FrameAnalysis(Preq);
	return 1;
}

/********************************************************************************************************************/



