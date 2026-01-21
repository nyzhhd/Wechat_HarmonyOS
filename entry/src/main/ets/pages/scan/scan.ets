import { router } from '@kit.ArkUI'
import { scanBarcode, scanCore } from '@kit.ScanKit'
import { abilityAccessCtrl, Permissions, common } from '@kit.AbilityKit'
import { Toast } from '../../utils/Toast'

@Entry
@Component
struct ScanPage {
  @State scanResult: string = ''
  @State isScanning: boolean = false
  @State showResult: boolean = false

  build() {
    Column() {
      // 顶部工具栏 - 添加顶部padding避免与状态栏重叠
      // Row() {
      //   // 返回按钮
      //   Image($r('app.media.ic_back_black'))
      //     .width(24)
      //     .height(24)
      //     .margin({ left: 16 })
      //     .onClick(() => {
      //       router.back()
      //     })
      //
      //   Text('扫一扫')
      //     .fontSize(18)
      //     .fontWeight(500)
      //     .fontColor(Color.Black)
      //     .layoutWeight(1)
      //     .textAlign(TextAlign.Center)
      //     .margin({ right: 40 })
      //
      //   // 相册按钮 - 使用ic_moment_pic作为相册图标
      //   Image($r('app.media.ic_moment_pic'))
      //     .width(24)
      //     .height(24)
      //     .margin({ right: 16 })
      //     .onClick(() => {
      //       this.scanFromAlbum()
      //     })
      // }
      // .width('100%')
      // .height(56)
      // .backgroundColor(Color.White)
      // .alignItems(VerticalAlign.Center)
      // .padding({ top: 32 }) // 添加顶部padding避免与状态栏重叠

      // 扫描区域 - 使用Column布局实现清晰的上中下结构
      Column() {
        // 顶部空白区域
        Blank()
          .layoutWeight(1)
          .backgroundColor('#1a000000')
        
        // 扫描框区域
        Row() {
          Blank()
            .layoutWeight(1)
            .backgroundColor('#1a000000')
          
          // 扫描框
          Stack() {
            Column() {
              Blank()
                .width(240)
                .height(240)
                .backgroundColor(Color.Transparent)
                .border({
                  width: 2,
                  color: '#07C160',
                  style: BorderStyle.Solid
                })
            }

            // 扫描线动画
            if (this.isScanning) {
              Column() {
                Blank()
                  .width(240)
                  .height(2)
                  .backgroundColor('#07C160')
                  .animation({
                    duration: 2000,
                    curve: Curve.Linear,
                    iterations: -1,
                    playMode: PlayMode.Alternate
                  })
              }
              .height(240)
            }
          }
          .width(240)
          .height(240)
          
          Blank()
            .layoutWeight(1)
            .backgroundColor('#1a000000')
        }
        .height(240)
        
        // 操作提示区域 - 位于扫描框下方
        Column() {
          Text('将二维码/条形码放入框内，即可自动扫描')
            .fontSize(14)
            .fontColor(Color.White)
            .margin({ top: 40, bottom: 40 })
          
          Row() {
            Column() {
              Image($r('app.media.sdt'))
                .width(32)
                .height(32)
              Text('手电筒')
                .fontSize(12)
                .fontColor(Color.White)
                .margin({ top: 8 })
            }
            .onClick(() => {
              this.toggleFlashlight()
            })
            .margin({ right: 40 })

            Column() {
              Image($r('app.media.ic_moment_pic'))
                .width(32)
                .height(32)
              Text('相册')
                .fontSize(12)
                .fontColor(Color.White)
                .margin({ top: 8 })
            }
            .onClick(() => {
              this.scanFromAlbum()
            })
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        
        // 底部空白区域
        Blank()
          .layoutWeight(1)
          .backgroundColor('#1a000000')
      }
      .layoutWeight(1)
      .backgroundColor('#000000')

      // 扫描结果弹窗
      if (this.showResult) {
        Column() {
          Text('扫描结果')
            .fontSize(16)
            .fontWeight(500)
            .fontColor(Color.Black)
            .margin({ top: 16 })
          
          Text(this.scanResult)
            .fontSize(14)
            .fontColor('#666666')
            .margin({ top: 12, left: 16, right: 16 })
            .textAlign(TextAlign.Start)
            .maxLines(3)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          
          Row() {
            Button('取消')
              .fontSize(16)
              .fontColor('#666666')
              .backgroundColor('#F0F0F0')
              .borderRadius(8)
              .layoutWeight(1)
              .height(44)
              .onClick(() => {
                this.showResult = false
                this.startScanning()
              })
            
            Button('复制')
              .fontSize(16)
              .fontColor(Color.White)
              .backgroundColor('#07C160')
              .borderRadius(8)
              .layoutWeight(1)
              .height(44)
              .margin({ left: 12 })
              .onClick(() => {
                this.copyToClipboard()
                this.showResult = false
                this.startScanning()
              })
          }
          .margin({ top: 24, left: 16, right: 16, bottom: 16 })
        }
        .width('80%')
        .backgroundColor(Color.White)
        .borderRadius(12)
        .position({ x: '10%', y: '30%' })
        .zIndex(10)
      }
    }
    .width('100%')
    .height('100%')
    .onAppear(() => {
      this.requestCameraPermission()
    })
    .onDisAppear(() => {
      this.stopScanning()
    })
  }

  // 请求相机权限
  async requestCameraPermission() {
    try {
      const atManager = abilityAccessCtrl.createAtManager()
      const permissions: Array<Permissions> = ['ohos.permission.CAMERA']
      
      // 使用getContext获取UIAbilityContext
      const context = getContext(this) as common.UIAbilityContext
      
      const result = await atManager.requestPermissionsFromUser(context, permissions)
      
      if (result.authResults[0] === 0) {
        this.startScanning()
      } else {
        Toast.show('需要相机权限才能使用扫一扫功能')
      }
    } catch (error) {
      console.error('权限申请失败:', error)
      Toast.show('权限申请失败')
    }
  }

  // 开始扫描
  async startScanning() {
    this.isScanning = true
    
    try {
      const options: scanBarcode.ScanOptions = {
        scanTypes: [scanCore.ScanType.QR_CODE],
        enableMultiMode: false,
        enableAlbum: false
      }
      
      // 使用getContext获取UIAbilityContext
      const context = getContext(this) as common.UIAbilityContext
      
      const result = await scanBarcode.startScanForResult(context, options)
      
      if (result && result.originalValue) {
        this.scanResult = result.originalValue
        this.showResult = true
        this.isScanning = false
      }
    } catch (error) {
      console.error('扫描失败:', error)
      Toast.show('扫描失败，请重试')
      this.isScanning = false
    }
  }

  // 停止扫描
  stopScanning() {
    this.isScanning = false
  }

  // 从相册选择图片扫描
  scanFromAlbum() {
    Toast.show('相册扫码功能开发中...')
  }

  // 切换手电筒
  toggleFlashlight() {
    Toast.show('手电筒功能开发中...')
  }

  // 复制到剪贴板
  copyToClipboard() {
    // 这里需要实现剪贴板功能
    Toast.show('已复制到剪贴板')
  }
}