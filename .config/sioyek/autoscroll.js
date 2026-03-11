const AUTOSCROLL_PREFIX = "origami.autoscroll";
const AUTOSCROLL_ACTIVE_KEY = `${AUTOSCROLL_PREFIX}.active`;
const AUTOSCROLL_VELOCITY_KEY = `${AUTOSCROLL_PREFIX}.velocity`;
const DEFAULT_AUTOSCROLL_VELOCITY = 300;
const AUTOSCROLL_VELOCITY_STEP = 100;
const AUTOSCROLL_MIN_VELOCITY = 50;
const AUTOSCROLL_MAX_VELOCITY = 100000;

function clampVelocityMagnitude(magnitude) {
  return Math.max(
    AUTOSCROLL_MIN_VELOCITY,
    Math.min(AUTOSCROLL_MAX_VELOCITY, magnitude),
  );
}

function readVelocity() {
  const rawVelocity = Number(sioyek_api.get_variable(AUTOSCROLL_VELOCITY_KEY));
  if (!Number.isFinite(rawVelocity) || rawVelocity === 0) {
    return DEFAULT_AUTOSCROLL_VELOCITY;
  }
  return rawVelocity;
}

function setVelocity(velocity) {
  const direction = velocity < 0 ? -1 : 1;
  const normalizedVelocity =
    direction * clampVelocityMagnitude(Math.abs(velocity));

  sioyek_api.set_variable(AUTOSCROLL_VELOCITY_KEY, normalizedVelocity);
  sioyek.set_fixed_velocity(String(normalizedVelocity));
  sioyek_api.set_variable(AUTOSCROLL_ACTIVE_KEY, true);
}

function stopAutoscroll() {
  sioyek.set_fixed_velocity("0");
  sioyek_api.set_variable(AUTOSCROLL_ACTIVE_KEY, false);
}

function startDown() {
  setVelocity(Math.abs(readVelocity()));
}

function startUp() {
  setVelocity(-Math.abs(readVelocity()));
}

function adjustSpeed(delta) {
  const currentVelocity = readVelocity();
  const direction = currentVelocity < 0 ? -1 : 1;
  const nextVelocity =
    direction *
    clampVelocityMagnitude(Math.abs(currentVelocity) + delta);

  sioyek_api.set_variable(AUTOSCROLL_VELOCITY_KEY, nextVelocity);

  if (sioyek_api.get_variable(AUTOSCROLL_ACTIVE_KEY) === true) {
    sioyek.set_fixed_velocity(String(nextVelocity));
  }
}

function increaseSpeed() {
  adjustSpeed(AUTOSCROLL_VELOCITY_STEP);
}

function decreaseSpeed() {
  adjustSpeed(-AUTOSCROLL_VELOCITY_STEP);
}

function toggleAutoscroll() {
  if (sioyek_api.get_variable(AUTOSCROLL_ACTIVE_KEY) === true) {
    stopAutoscroll();
    return;
  }

  setVelocity(readVelocity());
}
