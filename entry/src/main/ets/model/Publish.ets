export interface Publish {
  id: number;
  avatar: string | Resource;
  nickname: string;
  text: string;
  pictures?: (string | Resource)[];   // 九宫格
  time: string;                       // 友好时间
  liked: boolean;
  likes: string[];                    // 点赞人
  comments: Comment[];
}

export interface Comment {
  name: string;
  content: string;
}