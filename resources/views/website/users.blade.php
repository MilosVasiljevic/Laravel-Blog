@extends('layouts.website')
@section('content')    

    
    <div class="site-section bg-light">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <h1 style="text-align: center; margin-bottom: 80px;">Our users</h1>

            <div>
              @foreach ($users as $user)
                <div>
                  <!-- <p>ID: {{ $user->id }}</p> -->
                  <p><a href="{{ url('user/' . $user->id) }}"><img src="{{ asset($user->image) }}" alt="User Image" width="300"></a></p>
                  <p>{{ $user->name }}</p>
                  <p>{{ $user->email }}</p>
                  <p>{{ $user->description }}</p>
                 
                </div>
              @endforeach
            </div>  

          </div>

        </div>
      </div>
    </div>
@endsection