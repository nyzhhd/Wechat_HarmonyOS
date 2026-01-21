import { Publish, Comment } from '../../model/Publish'
import { PyqToolbar } from '../../component/PyqToolbar'
import { GridNine } from '../../component/GridNine'
import { CommentPop } from '../../component/CommentPop'
import { Toast } from '../../utils/Toast'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct Pyq {
  @State list: Publish[] = mockData()
  @State popShow: boolean = false
  @State popIndex: number = -1

  build() {
    Column() {
      // 0. 返回按钮 - 添加在顶部
      Row() {
        Image($r('app.media.ic_back_black'))
          .width(24)
          .height(24)
          .margin({ left: 16, top: 12 })
          .onClick(() => {
            // 返回上一页
            router.back()
          })
        Blank()
      }
      .width('100%')
      .height(48)
      .alignItems(VerticalAlign.Center)

      // 1. 顶部封面
      PyqToolbar({
        cover: $r('app.media.pyq_cover'),
        avatar: $r('app.media.ic_user_head1')
      })

      // 2. 动态列表
      List({ space: 12 }) {
        ForEach(this.list, (item: Publish, idx) => {
          ListItem() {
            this.PyqItem(item, idx)
          }
        }, (item: Publish) => item.id.toString())
      }
      .padding({ top: 40, left: 16, right: 16 })
      .layoutWeight(1)
      .backgroundColor('#f2f2f2')

      // 3. 评论弹出框
      if (this.popShow && this.popIndex >= 0) {
        CommentPop({
          show: $popShow,
          publish: $list[this.popIndex],
          onLikeToggle: () => this.likeToggle(this.popIndex),
          onComment: () => this.addComment(this.popIndex)
        })
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  PyqItem(publish: Publish, index: number) {
    Column() {
      // 头像 + 昵称 + 文字
      Row({ space: 12 }) {
        Image(publish.avatar)
          .width(48)
          .aspectRatio(1)
          .borderRadius(4)
        Column({ space: 6 }) {
          Row() {
            Text(publish.nickname)
              .fontSize(16)
              .fontWeight(500)
              .layoutWeight(1)
            
            // 时间显示在昵称右侧
            Text(publish.time)
              .fontColor('#999')
              .fontSize(13)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          
          Text(publish.text)
            .fontSize(15)
            .lineHeight(22)
            .fontColor('#333')
          if (publish.pictures) GridNine({ pics: publish.pictures })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .alignItems(VerticalAlign.Top) // 确保头像和昵称顶部对齐

      // 点赞/评论按钮
      Row() {
        Blank()
        Image($r('app.media.zan'))
          .width(16)
          .onClick(() => {
            animateTo({ duration: 150 }, () => {
              this.popShow = true;
              this.popIndex = index;
            })
          })
      }
      .width('100%')
      .margin({ top: 8 })

      // 点赞列表
      if (publish.likes.length > 0) {
        Row() {
          Image($r('app.media.ic_zan')).width(14)
          Text(publish.likes.join('、'))
            .fontSize(13)
            .fontColor('#576b95')
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
        .padding(8)
        .backgroundColor('#f7f7f7')
        .borderRadius(4)
        .width('100%')
      }

      // 评论列表
      ForEach(publish.comments, (c: Comment) => {
        Text() {
          Span(c.name).fontColor('#576b95')
          Span('：' + c.content)
        }
        .fontSize(13)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      })
    }
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .onClick(() => {
      if (this.popShow) {
        this.popShow = false;
      }
    })
  }

  // 弹出层
  aboutToAppear() {
    // 页面初始化逻辑
  }

  // 监听返回键，关闭弹窗
  onBackPress() {
    if (this.popShow) {
      this.popShow = false;
      return true; // 拦截返回事件
    }
    // 如果弹窗已关闭，返回上一页
    router.back()
    return true; // 拦截返回事件，防止默认行为
  }

  // 点赞/评论回调
  likeToggle(idx: number): void {
    let item = this.list[idx];
    item.liked = !item.liked;
    if (item.liked) {
      item.likes.unshift('我');
    } else {
      let me = item.likes.indexOf('我');
      if (me > -1) item.likes.splice(me, 1);
    }
    // 触发刷新
    this.list = [...this.list];
  }

  addComment(idx: number): void {
    // 占位：调起系统键盘或自定义输入弹窗
    Toast.show('评论功能开发中...');
  }
}

// 假数据
function mockData(): Publish[] {
  return [
    {
      id: 1,
      avatar: $r('app.media.ic_user_head3'),
      nickname: '同事小张',
      text: '今天天气真不错，出去骑了一圈车～',
      pictures: [$r('app.media.pic1'), $r('app.media.pic2'), $r('app.media.pic3')],
      time: '2 小时前',
      liked: false,
      likes: ['李美丽'],
      comments: []

    },
    {
      id: 2,
      avatar: $r('app.media.ic_user_head5'),
      nickname: '大脑斧',
      text: '下雪了！',
      pictures: [$r('app.media.pic4')],
      time: '昨天',
      liked: true,
      likes: ['我'],
      comments: []
    },
    {
      id: 3,
      avatar: $r('app.media.ic_user_head7'),
      nickname: '李总',
      text: '你在打工，我去旅游！',
      pictures: [$r('app.media.pic5'),$r('app.media.pic8'),$r('app.media.pic6'),$r('app.media.pic7')],
      time: '前天',
      liked: true,
      likes: ['我','大脑斧'],
      comments: []
    }
  ];
}