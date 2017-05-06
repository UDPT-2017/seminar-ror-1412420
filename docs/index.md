# SHORTEN.ME - Tutorial Making
## Phan Hữu Phước (1412420)

### Description
**Ứng dụng gồm 3 chức năng chính**
* Cho phép người dùng tạo một shortlink từ một link bất kì
* Revert một shortlink bất kì để  lấy url gốc
* Thống kê về số lượng truy cập shortlink
  * Trong 30 ngày gần nhất
  * Theo IP người dùng
  * Theo địa chỉ người dùng
  * Thông kê theo quốc gia

**Công nghệ sử dụng**:  *Ruby on Rails*
## Quá trình xây dựng step by step
### Một số tool cần cài đặt
* Sublime Text
* Postgres
* RVM cho quản lí ruby/rails version
* Git
* Heroku
* Ubuntu

### 1. Dựng frontend
**Những điều cần biết để dụng teamplate**
* HTML
* CSS (Boostrap)
* JS (jQuery)

**Gồm 3 template chính**
* Trang chủ (index) - tạo short link
* Trang revert link (như trang chủ) - revert một shortlink
* Trang thống kê
* Ngoài ra còn trang đăng nhập, đăng kí user
### 2. Xây dựng backend
#### 2.1. Init ứng dụng Rail

  `rails new seminar-ror-1412420`
#### 2.2. Các gem cần dùng
* gem 'devise'
* gem 'slim-rails'
* gem 'pg'yml
* gem 'factory_girl_rails'
* gem 'faker'
* gem 'gravatar_image_tag'
* gem 'valid_url'
* gem 'draper', '3.0.0.pre1'
* gem 'geocoder'
* gem 'chartkick'
* gem 'http'
* gem 'clipboard-rails'’

* **Chạy bundle cài gem**
* **Config database**

#### 2.3. Config template, UI, init git repo
* generate links controller

  `rails g controller links`
* Tạo new action và view cho links_controller
* Config route cho new action

    `resources :links, only: [:new]`

    (tạo new action tạm thời để có route dựng layout)
* Đổi tên applciation.html.erb thành application.html.slim (đổi luôn syntax)
* Copy trang index frontend vào tool convert erb to slim và paste vào application.html.slim giữa lại một số assert  tag có sẵn trước đó
* Thêm yield vào appliation slim
* Thêm các asset images, css và js từ template vào
* Chạy `rails s`
* Mở trình duyệt đảm bảo app chạy bình thường lần đầu
* init repo git
  * `git init`
  * `git remote add origin (URL repo github classroom)`
  * `git addd -A`
  * `git commit -m 'init project'`
  * `git push origin master`
#### 2.4 Generate model - migration

##### Generate model sau với các trường như trong hình sau
![ERD Diagram](../app/assets/images/erd.png?raw=true)
* Với model user ta sử dụng generate của devise
 `rails generate devise user`
* Chạy `rake db:migrate` để tạo  bảng


##### Validate model and relationship
* user

        devise :database_authenticatable, :registerable,
             :recoverable, :rememberable, :trackable, :validatable
        has_many :links
        validates :name, :email, :password, presence: true
        validates :email, uniqueness: true
* links

        has_many :hits
        enum link_type: [ :short, :full ]

        belongs_to :user, counter_cache: true, optional: true
        validates :full_link, :short_link, :link_type, presence: true
        validates :short_link, uniqueness: true, if: :short?
        validates :full_link, url: true
  * validates url là do gem `valid_url`
  * enum `short` cho biết record là shortlink, `full` record revert shortlink
* hit

    `belongs_to :link, counter_cache: true`
#### 2.5 Đăng nhập, đăng kí
* generate view devise

  `rails generate devise:views`
* copy các template
  * singup vào `views/devise/registrations/new.html.slim`
  * signin vào `views/devise/sessions/new.html.slim`
* Permit params `:name`

      def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        end


* Thêm `before_action :authenticate_user!` vào `links_controller`


#### 2.6 Chức năng shorlink

* Do `links_controller` phụ trách, gồm 2 action
  * `action new ` hiển thị form make shortlink
  * `action create` để create shortlink
* Config route cho `create action`

  `resources :links, only: [:new, :create]`

* Thuật toán create

    * Với mỗi link ta sẽ generate một mã coe duy nhất lưu vào database, lưu  thành công thì trả về js (form remote), ngược lại gặp lỗi redirect

  * Sử dụng `SecureRandom.urlsafe_base64` để generate shortcode
#### 2.7 Chức năng revert
* Do `revert_controller` phụ trách
* Gồm 2 action `index` và `create`

  `resources :revert, only: [:index, :create]`

* Thuật toán create revert
  * Sử dụng `gem http` để get link truyền vào trong vòng lặp while, đến khi nào không có location trong header thì dừng, nếu không xảy ra lỗi thì lưu link đó vào database trả kết quá chi người dùng, ngược lại báo lỗi
#### 2.8 Chức năng thống kê
* Do `trending_cotroller` phụ trách
* Gồm 2 action `index` và `show`

  `resources :trending, only: [:index, :show]`

* Sử dụng `chartkick` cho biểu đồ thống kê
* Tham khảo cách sử dụng `chartkick` tại [đây](http://chartkick.com/)

#### 2.9 Redirecting shortlink

* Do `shorten_controller` phụ trách
* Config route sau cùng trong `route.rb`

  `get ":id", to: "shorten#index"`

* Khi request vào controller này, sẽ dò trong bảng link xem shortlink có tồn tại, nếu có sẽ redirect đến link đích, ngược lại redirect về  trang chủ

#### 2.10 Một số gem đã dùng và chức năng
* `gravatar_image_tag` dùng gravatar
* `draper` decorator
* `geocoder` dùng một chức năng rất nhỏ của gem này cho việc lấy IP và location của request
* `clipboard-rails` thư việc JS dùng copy text

### 3. Testing - Spec

#### 3.1 Thiết lập gem cần thiết cho test
  group :test do
      gem 'database_cleaner'
      gem 'simplecov'
      gem 'shoulda-matchers'
      gem 'rails-controller-testing'
    end

  group :development, :test do
      gem 'rspec-rails'
    end
  gem 'factory_girl_rails'
  gem 'faker'

* Bundle cho cài đặt gem

#### 3.2 Viết test
* Viết factory cho các model
* Viết test cho các decorator
* Viết test cho model
* Viết test cho controller

### 4. Deply to HEROKU

* `heroku create`
* `git push heroku master`
* `heroku run rake db:migrate`
* `heroku open`

  *Ghi chú: nếu trong quá trình deploy gặp lỗi thì tìm cách fix*
