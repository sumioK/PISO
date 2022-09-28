max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count


# worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"


# port ENV.fetch("PORT") { 3000 }
bind "unix:///var/www/PISO/tmp/sockets/puma.sock"

environment ENV.fetch("RAILS_ENV") { "production" }


pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

plugin :tmp_restart

daemonize
stdout_redirect "#{tmp_path}/logs/puma.stdout.log", "#{tmp_path}/logs/puma.stderr.log", true